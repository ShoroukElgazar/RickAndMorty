//
//  UIViewCintroller+Error.swift
//  CommonUI
//
//  Created by Shorouk Mohamed on 14/01/2025.
//
import UIKit

extension UIViewController {
    
    public func showError(error:Error) {
        showErrorAlert(error: error.localizedDescription)
    }

    public func showErrorAlert(error: String) {
        let alert = UIAlertController(title: error, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
