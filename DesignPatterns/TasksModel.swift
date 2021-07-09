//
//  CurrentTasksModel.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 15.06.21.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var descript: String = ""
    @objc dynamic var dateOfCreation: NSDate = NSDate(timeIntervalSinceNow: 0)
    @objc dynamic var deadline: NSDate = NSDate(timeIntervalSinceNow: 0)
    @objc dynamic var status: Int = 0 // Can be only 0 = active, 1 = closed, 2 = removed
    
    init (title: String?, descript: String?, dateOfCreation: NSDate, deadline: NSDate) {
        self.title = title ?? ""
        self.descript = descript ?? ""
        self.dateOfCreation = dateOfCreation
        self.deadline = deadline
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override init() {}
}

class RealmListOfTasks {
    static let shared = RealmListOfTasks()
    
    let realmTasks = try! Realm()
    
    func getTask(for id: Int) -> Task? {
        return realmTasks.object(ofType: Task.self, forPrimaryKey: id)
    }
}
