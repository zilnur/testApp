//
//  UIControllerExtension.swift
//  TestApp
//
//  Created by Ильнур Закиров on 21.02.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Показывает алерт. В параметрах указываем заглавие, сообщение, названия и действия кнопок.
    func alert(title: String, message: String? = nil, firstActionTitle: String? = nil, firstActionHandler: ((UIAlertAction) -> Void )? = nil, cancelAlertTitle: String? = nil, cancelAlertHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let title = firstActionTitle {
            let alertAction = UIAlertAction(title: title, style: .default, handler: firstActionHandler)
            alertController.addAction(alertAction)
        }
        
        if let title = cancelAlertTitle {
            let cancelAction = UIAlertAction(title: title, style: .destructive, handler: cancelAlertHandler)
            alertController.addAction(cancelAction)
        }
        
        self.present(alertController, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
