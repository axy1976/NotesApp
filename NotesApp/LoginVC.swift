//
//  LoginVC.swift
//  NotesApp
//
//  Created by Akshay Jangir on 11/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "vnsgu_logo")
        return logo
    }()
    
    private let username : UITextField = {
        let textView = UITextField()
        textView.placeholder = "Enter Username"
        textView.textAlignment = .center
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        return textView
    }()

    private let password : UITextField = {
        let textView = UITextField()
        textView.placeholder = "Enter Password"
        textView.textAlignment = .center
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10
        return textView
    }()

    private let btn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = .init(red: 0.812, green: 0.315, blue: 0.115, alpha: 1)
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        return btn
    }()

    @objc func login() {
        if(username.text == "Admin" && password.text == "Admin")
        {
            let vc = NoteVC()
            navigationController?.pushViewController(vc, animated: true)
            UserDefaults.standard.setValue(username.text, forKey: "username")
            UserDefaults.standard.setValue("asdfgdewseds", forKey: "session token")
            self.dismiss(animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Please Enter Correct Credentials", message: "Incorrect Username Or Password", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            DispatchQueue.main.async {
                self.present(alert, animated: true) {
                    self.username.text = ""
                    self.password.text = ""
                    
                }
            }
        }
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logo)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(btn)
        view.backgroundColor = .init(red: 0.918, green: 0.918, blue: 0.918, alpha: 1)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logo.frame = CGRect(x: view.width/2-150, y: 130, width: 300, height: 220)
        username.frame = CGRect(x: 30, y: logo.bottom + 20, width: view.width - 60, height: 40)
        password.frame = CGRect(x: 30, y: username.bottom + 20, width: view.width - 60, height: 40)
        btn.frame = CGRect(x: 30, y: password.bottom + 20, width: view.width - 60, height: 40)
    }
}
