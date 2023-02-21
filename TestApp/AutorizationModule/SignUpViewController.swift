//
//  SignUpViewController.swift
//  TestApp
//
//  Created by Ильнур Закиров on 21.02.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var mailTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func toEnterModule(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBSegueAction func presentMainController(_ coder: NSCoder) -> UITabBarController? {
        if isFilled() && isCorrect() {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainController = storyBoard.instantiateViewController(withIdentifier: "mainController") as! UITabBarController
            present(mainController, animated: true)
        } else  if !isFilled() {
            alert(title: "Ошибка", message: "Заполните пустые поля", firstActionTitle: "Ок")
            return nil
        } else if !isCorrect() {
            alert(title: "Ошибка", message: "Указан неправельный логин или пароль", firstActionTitle: "Oк")
            return nil
        }
        return nil
    }
    
    //проверяет заполненность текстовых полей
    func isFilled() -> Bool{
        guard mailTextFiled.text != "", passTextField.text != "" else { return false }
        return true
    }
    
    //проверяет корректность введенных данных
    func isCorrect() -> Bool {
        guard mailTextFiled.text == "test@mail.ru", passTextField.text == "12345" else { return false }
        return true
    }
}
