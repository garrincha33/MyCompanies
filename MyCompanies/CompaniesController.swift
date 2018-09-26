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
    func didEditCompany(company: Company) {
        guard let newRow = companiesArray.index(of: company) else {return}
        let reloadIndexPath = IndexPath(row: newRow, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    
    func didAddCompany(company: Company) {
        companiesArray.append(company)
        let newPath = IndexPath(row: companiesArray.count - 1, section: 0)
        tableView.insertRows(at: [newPath], with: .automatic)
    }

    var companiesArray = [Company]()

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
        return companiesArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let company = companiesArray[indexPath.row]
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
  
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let company = self.companiesArray[indexPath.row]
            print("attempting to delete company", company.name ?? "")
            self.companiesArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistantContainer.viewContext
            context.delete(company)
            do {
                try context.save()
            } catch let err {
                print("unable to delete", err)
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editingCompanies)
            
        
        return [deleteAction, editAction]
    }
    
    //MARK:-
    private func editingCompanies(action: UITableViewRowAction, indexPath: IndexPath) {
        let controller = CreateCompanyController()
        controller.company = companiesArray[indexPath.row]
        controller.delegate = self
        let navController = CustomNavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }

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
                self.companiesArray = companines
                self.tableView.reloadData()
            }
 
        } catch let err {
            print("unable to fetch companies", err)
        }
    }
}

