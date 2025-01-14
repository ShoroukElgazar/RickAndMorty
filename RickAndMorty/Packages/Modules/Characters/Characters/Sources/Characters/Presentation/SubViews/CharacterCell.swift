//
//  CharacterCell.swift
//  Characters
//
//  Created by Shorouk Mohamed on 13/01/2025.
//


import CommonModels
import SwiftUI

class CharacterCell: UITableViewCell {
    private var hostingController: UIHostingController<CharacterCardCellView>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configure(with character: Character, didSelectCharacter: @escaping () -> Void) {
        if #available(iOS 16.0, *) {
            contentConfiguration = UIHostingConfiguration {
                CharacterCardCellView(
                    didSelectCharacter: didSelectCharacter,
                    character: character
                )
                .padding(.trailing, 16)
                .padding(.leading, 16)
            }
        } else {
            let swiftUIView = CharacterCardCellView(
                didSelectCharacter: didSelectCharacter,
                character: character
            )
            hostingController = UIHostingController(rootView: swiftUIView)
            
            guard let hostingController = hostingController else { return }
            hostingController.view.backgroundColor = .clear
            
            contentView.addSubview(hostingController.view)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                hostingController.view.widthAnchor.constraint(equalToConstant: 262)
            ])
        }
    }
}
