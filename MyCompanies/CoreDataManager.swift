//
//  CoreDataManager.swift
//  MyCompanies
//
//  Created by Richard Price on 23/09/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistantContainer: NSPersistentContainer = {
        let containter = NSPersistentContainer(name: "CompaniesDB")
        containter.loadPersistentStores(completionHandler: { (storeDescription, err) in
            if let err =  err {
                fatalError("unable to load db store \(err)")
            }
        })
        return containter
    }()
}
