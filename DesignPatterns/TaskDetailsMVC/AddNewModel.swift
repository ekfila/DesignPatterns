//
//  AddNewModel.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 09.07.21.
//

import Foundation

//The model for the whole project is in TasksModel.swift

private let SECONDS_IN_DAY: Double = 60 * 60 * 24

enum TasksError: Error {
    case wrongData(title: String, message: String)
}

extension RealmListOfTasks {
    func add(task: Task) throws {
       
        if task.title == "" {
            throw TasksError.wrongData(title: "Empty title", message: "Enter the title of the task")
        }
        
        var titles: Set<String> {
            get { Set(realmTasks.objects(Task.self).map{$0.title}) }
        }
        if titles.contains(task.title) {
            throw TasksError.wrongData(title: "Repeated title", message: "The list of tasks contains a task with such title. Please choose another title.")
        }
        
        if task.descript == "" {
            throw TasksError.wrongData(title: "Empty description", message: "Enter the description of the task")
        }
        
        if task.deadline.timeIntervalSinceNow < -SECONDS_IN_DAY {
            throw TasksError.wrongData(title: "Invalid date of deadline", message: "The date of deadline must be not earlier than the date of creation")
        }

        try! realmTasks.write {
            task.id = realmTasks.objects(Task.self).count
            realmTasks.add(task)
        }
    }
    
    func changeStatus(task: Task, to status: Int) throws {
        if status < 0 || status > 2 {
            throw TasksError.wrongData(title: "no such status", message: "it should be 0, 1 or 2")
        }
        try! realmTasks.write {
            task.status = status
        }
    }
}
