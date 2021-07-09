//
//  ClosedTasksConfigurator.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 01.07.21.
//

import Foundation

protocol ClosedTasksConfiguratorProtocol {
    func configure(with viewController: ClosedTasksTableViewController)
}

class ClosedTasksConfigurator: ClosedTasksConfiguratorProtocol {
    
    func configure(with viewController: ClosedTasksTableViewController) {
        let presenter = ClosedTasksPresenter()
        let interactor = ClosedTasksInteractor()
        let router = ClosedTasksRouter()
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = viewController
    }
}
