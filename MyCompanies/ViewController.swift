//
//  ViewController.swift
//  MyCompanies
//
//  Created by Richard Price on 17/09/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "My Companies"
        setupNavStyle()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddButton))
        
    }
    @objc fileprivate func handleAddButton() {
        print("testing add button")
        
    }
    
    fileprivate func setupNavStyle() {
        let lightRed = UIColor(red: 247/255, green: 66/225, blue: 82/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = lightRed
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}

