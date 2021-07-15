//
//  NoteVC.swift
//  NotesApp
//
//  Created by Akshay Jangir on 11/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import UIKit

class NoteVC: UIViewController {

    private var notesArray = [String]()
    
    private let notesTableVIew = UITableView()
    
    private func fetchNotes()
    {
        let path = DataService.getDocDir()
        do{
            let items = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
            notesArray.removeAll()
            for item in items
            {
                notesArray.append(item.lastPathComponent)
            }
        } catch {
            print("error")
        }
        notesTableVIew.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchNotes()
        checkAuth()
    }
    
    private func checkAuth()
    {
        if let token = UserDefaults.standard.string(forKey: "session token"),
           let name = UserDefaults.standard.string(forKey: "username")
        {
            print(token , name)
        }
        else{
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Notes"
        view.addSubview(notesTableVIew)
        print(DataService.getDocDir())
        
        let additem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNewNote))
        let logoutbtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logout))
        navigationItem.setRightBarButton(additem, animated: true)
        navigationItem.setLeftBarButton(logoutbtn, animated: true)
        
        setupTableView()
    }
    
    @objc private func openNewNote()
    {
        let vc = NewNoteVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func logout()
    {
        UserDefaults.standard.setValue(nil, forKey: "session token")
        UserDefaults.standard.setValue(nil, forKey: "username")
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notesTableVIew.frame = view.bounds
    }
}
extension NoteVC:UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView()
    {
        notesTableVIew.register(UITableViewCell.self, forCellReuseIdentifier: "notes")
        notesTableVIew.delegate = self
        notesTableVIew.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath)
        cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewNoteVC()
        vc.updateFile = notesArray[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let filename = notesArray[indexPath.row]
        
        let path = DataService.getDocDir().appendingPathComponent(filename)
        print(path)
        
        do{
            try FileManager.default.removeItem(at: path)
        } catch
        {
            print(error)
        }
        
        self.notesArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
