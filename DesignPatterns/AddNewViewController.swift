//
//  AddNewViewController.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 09.06.21.
//

import UIKit
import RealmSwift
import SPAlert

class AddNewViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptTextView: UITextView!
    
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    @IBOutlet weak var statePicker: UISegmentedControl!
    
    @IBOutlet weak var addButton: UIButton!
    
    var task: Task?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let state = Status.shared.state
        
        statePicker.selectedSegmentIndex = state.rawValue
        
        descriptTextView.isHidden = false
        descriptTextView.isEditable = true
        descriptTextView.layer.borderWidth = 0.5
        descriptTextView.layer.borderColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        
        switch state {
        case Status.State.add:
            statePicker.isHidden = true
            addButton.isHidden = false
            titleTextField.isEnabled = true
            descriptTextView.isEditable = true
            deadlinePicker.isEnabled = true
        default:
            statePicker.isHidden = false
            statePicker.isEnabled = true
            addButton.isHidden = true
            titleTextField.isEnabled = false
            descriptTextView.isEditable = false
            deadlinePicker.isEnabled = false
            titleTextField.text = task?.title
            descriptTextView.text = task?.descript
            deadlinePicker.date = (task?.deadline as? Date) ?? (NSDate(timeIntervalSinceNow: 0) as Date)
        }

    }
    
    @IBAction func changeStatus(_ sender: Any) {
        Status.shared.state = Status.State(rawValue: statePicker.selectedSegmentIndex)!
        if task != nil {
            let realm = RealmListOfTasks.shared.realmTasks
            try! realm.write {
            task!.status = Status.shared.state.rawValue
                realm.add(task!, update: .all)
            }
        }
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        do {
            let taskTitle = titleTextField.text
            let taskDescription = descriptTextView.text
            let taskDeadline = deadlinePicker.date as NSDate
            let task = Task(title: taskTitle ?? "", descript: taskDescription ?? "", deadline: taskDeadline)
            
            try RealmListOfTasks.shared.add(task: task)
            SPAlert.present(title: "", preset: .done)
        }
           
        catch RealmListOfTasks.TasksError.wrongData(let title, let message) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in }))
            self.present(alert, animated: true, completion: nil)
        }
           
        catch {
            print("empty catch")
        }
    }
}
