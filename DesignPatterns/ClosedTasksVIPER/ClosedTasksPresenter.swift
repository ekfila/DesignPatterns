//
//  ClosedTasksPresenter.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 29.06.21.
//

import Foundation
import Bond

protocol ClosedTasksPresenterProtocol {
    
    var router: ClosedTasksRouterProtocol! {set get}
    var interactor: ClosedTasksInteractorProtocol! {set get}
    
    func getTaskTitle(for id: Int) -> String?
    func getTaskStatus(for id: Int) -> Int?
    func getStatusString(for status: Int) -> String?

    func cellClicked(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class ClosedTasksPresenter: ClosedTasksPresenterProtocol {
    
    var router: ClosedTasksRouterProtocol!
    var interactor: ClosedTasksInteractorProtocol!
    
    func getTaskTitle(for id: Int) -> String? {
        return interactor.getTask(for: id)?.title
    }
    
    func getTaskStatus(for id: Int) -> Int? {
        return interactor.getTask(for: id)?.status
    }
    
    func getStatusString(for status: Int) -> String? {
        return
            interactor.statusToString(status: status)
    }
    
    func cellClicked(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.openTask(tableView, didSelectRowAt: indexPath)
    }
}
