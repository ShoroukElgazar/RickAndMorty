//
//  UIViewCintroller+Loader.swift
//  CommonUI
//
//  Created by Shorouk Mohamed on 14/01/2025.
//
import UIKit

extension UIViewController {
    private var loaderView: UIActivityIndicatorView? {
        return view.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
    }
    
    public func showLoader() {
        if let existingLoader = loaderView {
            existingLoader.startAnimating()
            return
        }
        
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loader.startAnimating()
    }
    
    public func hideLoader() {
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
    }
}
