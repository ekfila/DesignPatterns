//
//  CurrentTasksViewController.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 09.06.21.
//

import UIKit
import Bond

class CurrentTasksViewController: UITableViewController {

    @IBOutlet weak var currentTasksTableView: UITableView!
    
    let viewModel: ViewModelProtocol = CurrentTasksViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.idOfCurrentTasks.bind(to: currentTasksTableView) { (dataSourse, indexPath, tableView) -> UITableViewCell in

            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
            cell.taskId = dataSourse[indexPath.row]
            cell.title.text = self.viewModel.getTask(for: dataSourse[indexPath.row])?.title

            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "showTask", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? TableViewCell {
            let taskId = cell.taskId!
            if segue.identifier == "showTask" {
                let vc = segue.destination as! AddNewViewController
                //Status.shared.state = .active
                let task = viewModel.getTask(for: taskId)!
                vc.task = task
            }
        }
    }

}
