//
//  UIViewController+ShowAlert.swift
//  ThirdWayV-Task
//
//  Created by Yousef Mohamed on 11/06/2022.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
