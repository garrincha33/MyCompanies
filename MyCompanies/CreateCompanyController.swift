//
//  CreateCompanyController.swift
//  MyCompanies
//
//  Created by Richard Price on 20/09/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: TestCompanies)
}

class CreateCompanyController: UIViewController {
    
    var delegate: CreateCompanyControllerDelegate?
    
    //MARK:- UI setup
    let nameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Name"
        lable.textColor = .black
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let lightBlueBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Company Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    //MARK:-

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .darkBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "Create Company"
        
        
    }
    
    @objc fileprivate func handleSave() {
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(nameTextField.text, forKey: "name")
        do {
            try context.save()
        } catch let err {
            print("unable to save to db", err)
        }
    }
    
    @objc fileprivate func handleCancel() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    private func setupUI() {
        view.addSubview(lightBlueBackground)
        lightBlueBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        lightBlueBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameLable)
        nameLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLable.rightAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLable.topAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLable.bottomAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
}
