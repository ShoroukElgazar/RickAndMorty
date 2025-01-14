import UIKit
import CommonModels
import CommonUI
import Combine

public class CharactersViewController: UIViewController {
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private var characters: [Character] = []
    private var filteredCharacters: [Character] = []
    private let viewModel: any CharactersViewModelProtocol
    var didSelectCharacter: (Character) -> Void
    private var isFetchingData: Bool = false
    private var page = 1
    private var status: Status = .all
    fileprivate var filterButtons: [UIButton] = []
    private var activityIndicator: UIActivityIndicatorView!
    private var loaderCancellable: Cancellable?
    private var errorCancellable: Cancellable?
    private lazy var noDataLabel: UILabel = createNoDataLabel()
    private lazy var titleLabel: UILabel = createTitleLabel()


    public init(viewModel: any CharactersViewModelProtocol,didSelectCharacter: @escaping (Character) -> Void) {
        self.viewModel = viewModel
        self.didSelectCharacter = didSelectCharacter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupFilterButtons()
        setupTableView()
        bindViewModel()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        Task {
            await filterCharacters(status: .all, isRefreshing: false)
        }
    }
    
    private func createNoDataLabel() -> UILabel {
        let label = UILabel()
        label.text = "No characters available."
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Characters"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func bindViewModel() {
        loaderCancellable = viewModel.loaderState.sink { [weak self] loading in
            guard let self else { return }
            DispatchQueue.main.async {
                if loading {
                    self.showLoader()
                } else {
                    self.hideLoader()
                }
            }
         
        }
        errorCancellable = viewModel.errorState.sink { [weak self] errorMessage in
            guard let self else { return }
            guard let errorMessage = errorMessage else { return }
            DispatchQueue.main.async {
                self.showErrorAlert(error: errorMessage)
            }
         
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(noDataLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: filterButtons.last?.bottomAnchor ?? titleLabel.bottomAnchor, constant: 80),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
    }
    
  @objc private func refreshData() {
        Task {
            await filterCharacters(status: status, isRefreshing: true)
        }
    }
    
    fileprivate func filterCharacters(status: Status,isRefreshing: Bool) async {
            isFetchingData = true
            switch status {
            case .all:
                let fetchedCharacters =  await viewModel.fetchCharacters(isRefreshing: isRefreshing)
                self.characters = fetchedCharacters
            case .Alive,.Dead,.unknown:
                let filteredCharacters =  await viewModel.filterCharacters(status: status, isRefreshing: isRefreshing)
                self.characters = filteredCharacters
            }
         
          DispatchQueue.main.async {
              self.noDataLabel.isHidden = !self.characters.isEmpty
              self.tableView.reloadData()
              self.isFetchingData = false
              self.refreshControl.endRefreshing()
          }
    }
    
    deinit {
        loaderCancellable?.cancel()
        errorCancellable?.cancel()
    }
}

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        cell.configure(with: characters[indexPath.row], didSelectCharacter: { [weak self] in
            guard let self else { return }
            didSelectCharacter(self.characters[indexPath.row])
        })
        return cell
    }
        
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.last, lastIndexPath.row >= characters.count - 7 && !isFetchingData && page >= 1 {
            Task {
                await filterCharacters(status: status, isRefreshing: false)
            }
        }
    }
}

extension CharactersViewController {
    private func setupFilterButtons() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let filterAliveCharactersButton = createFilterButton(title: "Alive", action: #selector(filterAliveCharactersTapped))
        let filterDeadCharactersButton = createFilterButton(title: "Dead", action: #selector(filterDeadCharactersTapped))
        let filterunKnownCharactersButton = createFilterButton(title: "unknown", action: #selector(filterunKnownCharactersTapped))
        let filterallCharactersButton = createFilterButton(title: "All", action: #selector(filterAllCharactersTapped))
        
        stackView.addArrangedSubview(filterallCharactersButton)
        stackView.addArrangedSubview(filterAliveCharactersButton)
        stackView.addArrangedSubview(filterDeadCharactersButton)
        stackView.addArrangedSubview(filterunKnownCharactersButton)
 
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

  

    private func createFilterButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: action, for: .touchUpInside)
        button.addTarget(self, action: #selector(handleButtonTap(_:)), for: .touchUpInside)
        
        filterButtons.append(button)
        
        return button
    }

    @objc private func handleButtonTap(_ sender: UIButton) {
        resetAllButtons()
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        sender.layer.borderColor = UIColor.black.cgColor
    }

    private func resetAllButtons() {
        for button in filterButtons {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
    @objc private func filterAliveCharactersTapped() {
        status = .Alive
        Task {
            await filterCharacters(status: .Alive, isRefreshing: false)
        }
    }

    @objc private func filterDeadCharactersTapped() {
        status = .Dead
        Task {
            await filterCharacters(status: .Dead, isRefreshing: false)
        }
    }

    @objc private func filterunKnownCharactersTapped() {
        status = .unknown
        Task {
            await filterCharacters(status: .unknown, isRefreshing: false)
        }
    }
    
    
    @objc private func filterAllCharactersTapped() {
        status = .all
        Task {
            await filterCharacters(status: .all, isRefreshing: false)
        }
    }
}
