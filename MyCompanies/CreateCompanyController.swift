//
//  CreateCompanyController.swift
//  MyCompanies
//
//  Created by Richard Price on 20/09/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "Create Company"
    }
    
    @objc fileprivate func handleSave() {
        print("handle save testing")
    }
    
    @objc fileprivate func handleCancel() {
        
        dismiss(animated: true, completion: nil)
        
    }
}
