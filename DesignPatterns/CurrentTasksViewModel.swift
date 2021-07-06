//
//  CurrentTasksViewModel.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 21.06.21.
//

import Foundation
import Bond

class CurrentTasksViewModel {
    
    var tasks = RealmListOfTasks.shared.realmTasks.objects(Task.self)
        
    var idOfCurrentTasks: MutableObservableArray<Int> {
        return MutableObservableArray(tasks.filter{$0.status == 0}.map({$0.id}))
    }
    
    func getTask(for id: Int) -> Task? {
        return RealmListOfTasks.shared.getTask(for: id)
    }
}
