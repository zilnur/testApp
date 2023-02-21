//
//  EnterViewController.swift
//  TestApp
//
//  Created by Ильнур Закиров on 21.02.2023.
//

import UIKit

class EnterViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    

    @IBSegueAction func toMainModule(_ coder: NSCoder) -> UITabBarController? {
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
        guard mailTextField.text != "", passTextField.text != "" else { return false }
        return true
    }
    
    //проверяет корректность введенных данных
    func isCorrect() -> Bool {
        guard mailTextField.text == "test@mail.ru", passTextField.text == "12345" else { return false }
        return true
    }
}
