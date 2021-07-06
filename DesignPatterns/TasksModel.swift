//
//  CurrentTasksModel.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 15.06.21.
//

import Foundation
import RealmSwift

class Status {
    static let shared = Status()

    enum State: Int {
        case active = 0
        case closed = 1
        case removed = 2
        case add = 3
        
        func toString() -> String? {
            switch self {
            case .active:
                return "active"
            case .closed:
                return "closed"
            case .removed:
                return "removed"
            default:
                return "add"
            }
        }
    }

    var state: State

    init() {
       state = .add
    }
}

class Task: Object {
    @objc dynamic var id: Int
    @objc dynamic var title: String
    @objc dynamic var descript: String
    @objc dynamic let dateOfCreation: NSDate
    @objc dynamic var deadline: NSDate
    @objc dynamic var status: Int // Can be only 0 = active, 1 = closed, 2 = removed, 3 = add
    
    init (title: String?, descript: String?, deadline: NSDate) {
        id = 0
        self.title = title ?? ""
        self.descript = descript ?? ""
        dateOfCreation = NSDate(timeIntervalSinceNow: 0)
        self.deadline = deadline
        status = 0
    }
    
    override static func primaryKey() -> String? {
            return "id"
        }
    
    required override init() {
        id = 0
        title = ""
        descript = ""
        dateOfCreation = NSDate(timeIntervalSinceNow: 0)
        deadline = NSDate(timeIntervalSinceNow: 0)
        status = 0

    }
}

class RealmListOfTasks {
    static let shared = RealmListOfTasks()
    
    enum TasksError: Error {
        case wrongData(title: String, message: String)
    }
    
    let realmTasks = try! Realm()
    
    var titles: Set<String> {
        get { Set(realmTasks.objects(Task.self).map{$0.title}) }
    }
    
    func getTask(for id: Int) -> Task? {
        return realmTasks.object(ofType: Task.self, forPrimaryKey: id)
    }
    
    func add(task: Task) throws {
       
        if task.title == "" {
            throw TasksError.wrongData(title: "Empty title", message: "Enter the title of the task")
        }
        if titles.contains(task.title) {
            throw TasksError.wrongData(title: "Repeated title", message: "The list of tasks contains a task with such title. Please choose another title.")
        }
        if task.descript == "" {
            throw TasksError.wrongData(title: "Empty description", message: "Enter the description of the task")
        }
        if task.deadline.timeIntervalSinceNow < -86400 {
            throw TasksError.wrongData(title: "Invalid date of deadline", message: "The date of deadline must be not earlier than the date of creation")
        }

        try! realmTasks.write {
            task.id = realmTasks.objects(Task.self).count
            realmTasks.add(task)
        }
    }
    
    private func changeStatus(task: Task, to status: Int) throws {
        if status < 0 || status > 2 {
            throw TasksError.wrongData(title: "no such status", message: "it should be 0, 1 or 2")
        }
        try! realmTasks.write {
            task.status = status
        }
    }
    
    func closeTask(task: Task) {
        do {
            try changeStatus(task: task, to: 1)
        } catch {
            print("wrong code of status")
        }
    }
    
    func removeTask(task: Task) {
        do {
            try changeStatus(task: task, to: 2)
        } catch {
            print("wrong code of status")
        }
    }
    
    func activateTask(task: Task) {
        do {
            try changeStatus(task: task, to: 0)
        } catch {
            print("wrong code of status")
        }
    }
}
