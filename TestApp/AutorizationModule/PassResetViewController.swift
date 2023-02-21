//
//  PassResetViewController.swift
//  TestApp
//
//  Created by Ильнур Закиров on 21.02.2023.
//

import UIKit

class PassResetViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func resetButtonTaped(_ sender: Any) {
        if mailTextField.text != "" {
            alert(title: "Успешно", message: "Инструкция по сбросу пароля придет Вам на почту", firstActionTitle: "Ок", firstActionHandler: {_ in
                self.navigationController?.popToRootViewController(animated: true)
            })
        } else {
            alert(title: "Ошибка", message: "Заполните пустые поля", firstActionTitle: "Ок")
        }
    }
    
}
