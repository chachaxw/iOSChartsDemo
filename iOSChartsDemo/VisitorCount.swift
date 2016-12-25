//
//  VisitorCount.swift
//  iOSChartsDemo
//
//  Created by Wei Zhou on 25/12/2016.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import Foundation
import RealmSwift

class VisitorCount: Object {
    dynamic var date: Date = Date()
    dynamic var count: Int = Int(0)
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func delete() {
        do {
            let realm = try Realm()
            realm.deleteAll()
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
