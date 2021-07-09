//
//  ClosedTasksRouter.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 29.06.21.
//

import UIKit

protocol ClosedTasksRouterProtocol {
    func openTask(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

class ClosedTasksRouter: ClosedTasksRouterProtocol {
    
    weak var viewController: ClosedTasksTableViewController!
    
    func openTask(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        viewController.performSegue(withIdentifier: "showOldTask", sender: cell)
    }
}
