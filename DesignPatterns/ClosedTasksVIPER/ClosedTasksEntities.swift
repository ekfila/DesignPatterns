//
//  ClosedTasksEntities.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 09.07.21.
//

import Foundation

extension Task {
    func statusToString(status: Int) -> String? {
        if status == 0 {
            return "active"
        } else if status == 1 {
            return "closed"
        } else if status == 2 {
            return "removed"
        } else {
            return nil
        }
    }
}

//Task and RealmListOfTasks is from TasksModel.swift
