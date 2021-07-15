//
//  NewNoteVC.swift
//  NotesApp
//
//  Created by Akshay Jangir on 11/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import UIKit

class NewNoteVC: UIViewController {

    var updateFile = ""
    
    private let nameTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "File Name"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemFill
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let contentTxtView:UITextView = {
        let textview = UITextView()
        textview.backgroundColor = .systemFill
        return textview
    }()
    
    private let save_btn : UIButton = {
        let save = UIButton()
        save.setTitle("Save", for: .normal)
        save.backgroundColor = .init(red: 0.793, green: 0.232, blue: 0.026, alpha: 1)
        save.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        save.layer.cornerRadius = 6
        return save
    }()
    
    @objc private func saveNote()
    {
        let name = nameTextField.text!
        let content = contentTxtView.text!
        let filepath = DataService.getDocDir().appendingPathComponent("\(name).txt")
        
        do{
            try content.write(to: filepath, atomically: true, encoding: .utf8)
            
            let fetchedContent = try String(contentsOf: filepath)
            print(fetchedContent)
            
            nameTextField.text = ""
            contentTxtView.text = ""
            
            let alert = UIAlertController(title: "Success", message: "Created Note", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { [weak self] _ in
                
                self?.navigationController?.popViewController(animated: true)
            }))
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        } catch {
            print("error")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameTextField)
        view.addSubview(contentTxtView)
        view.addSubview(save_btn)
        
        if updateFile != "" {
            nameTextField.text = updateFile.components(separatedBy: ".").first
            nameTextField.isEnabled = false
            
            let filePath = DataService.getDocDir().appendingPathComponent(updateFile)
            
            do{
                let content = try String(contentsOf: filePath )
                contentTxtView.text = content
            } catch {
                print("error")
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextField.frame = CGRect(x: 40, y: 100, width: view.width - 80, height: 40)
        contentTxtView.frame = CGRect(x: 40, y: nameTextField.bottom + 20, width: view.width - 80, height: 300)
        save_btn.frame = CGRect(x: 40, y: contentTxtView.bottom + 20, width: view.width - 80, height: 40)
    }
}
