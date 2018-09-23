//
//  ViewController.swift
//  MyCompanies
//
//  Created by Richard Price on 17/09/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
    
    func didAddCompany(company: TestCompanies) {
        companies.append(company)
        let newPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newPath], with: .automatic)
    }

    var companies = [
        TestCompanies(name: "Apple", founded: Date()),
        TestCompanies(name: "Facebook", founded: Date()),
        TestCompanies(name: "Google", founded: Date())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanines()
        
        view.backgroundColor = .white
        navigationItem.title = "My Companies"
        //setupNavStyle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddButton))
        tableView.backgroundColor = .darkBlue
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
    }
    
    //MARK:- UITableView Implementation
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        cell.backgroundColor = .tealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    //MARK:-

    @objc fileprivate func handleAddButton() {
        print("testing add button")
        let createCompanyController = CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        createCompanyController.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
    fileprivate func fetchCompanines() {
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companines = try context.fetch(fetchRequest)
            companines.forEach { (company) in
                print(company.name ?? "")
            }
        } catch let err {
            print("unable to fetch companies", err)
        }
    }
}

