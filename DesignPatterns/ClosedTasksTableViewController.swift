//
//  ClosedTasksTableViewController.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 09.06.21.
//

import UIKit
import Bond

//protocol ClosedTasksViewProtocol {
//    
//}

class ClosedTasksTableViewController: UITableViewController {
    
    @IBOutlet var closedTasksTableView: UITableView!
    
    var presenter: ClosedTasksPresenterProtocol!
    let configurator: ClosedTasksConfiguratorProtocol = ClosedTasksConfigurator()
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.interactor.idOfClosedTasks.bind(to: closedTasksTableView) { (dataSourse, indexPath, tableView) -> UITableViewCell in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClosedTaskCell") as! ClosedTaskCell
            cell.taskId = dataSourse[indexPath.row]
            cell.titleLabel.text = self.presenter.getTaskTitle(for: cell.taskId!)
            cell.statusLabel.text = Status.State(rawValue: self.presenter.getTaskStatus(for: cell.taskId!)!)!.toString()

            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        presenter.cellClicked(tableView, didSelectRowAt: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? ClosedTaskCell {
            let taskId = cell.taskId!
            if segue.identifier == "showOldTask" {
                let vc = segue.destination as! AddNewViewController
                Status.shared.state = Status.State(rawValue: self.presenter.getTaskStatus(for: taskId)!)! //.closed or .removed
                let task = presenter.interactor.getTask(for: taskId)!
                vc.task = task
            }
        }
    }

}

// MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

/*
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

    // Configure the cell...

    return cell
}
*/
