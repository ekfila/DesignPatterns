//
//  ClosedTasksInteractor.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 29.06.21.
//

import Foundation
import Bond

protocol ClosedTasksInteractorProtocol {
    var tasks: [Task] {get}
    var idOfClosedTasks: MutableObservableArray<Int>  {get}
    func getTask(for id: Int) -> Task?
}

class ClosedTasksInteractor: ClosedTasksInteractorProtocol {
    
    var tasks: [Task] {
        return Array(RealmListOfTasks.shared.realmTasks.objects(Task.self))
    }
    
    var idOfClosedTasks:        MutableObservableArray<Int> {
        return MutableObservableArray(tasks.filter{$0.status == 1 || $0.status == 2}.map({$0.id}))
    }
        
    
    func getTask(for id: Int) -> Task? {
        return RealmListOfTasks.shared.getTask(for: id)
    }
}
