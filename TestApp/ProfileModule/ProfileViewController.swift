//
//  ProfileViewController.swift
//  TestApp
//
//  Created by Ильнур Закиров on 19.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func exitButtonTapped(_ sender: Any) {
        alert(title: "Выход",
              message: "Вы уверены, что хотите выйти из аккаунта",
              firstActionTitle: "Отмена",
              cancelAlertTitle: "Выход") { action in
            self.navigationController?.dismiss(animated: true)
        }
    }
    

}
