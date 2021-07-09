//
//  AddNewViewController.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 09.06.21.
//

import UIKit
import SPAlert

class AddNewViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptTextView: UITextView!
    
    @IBOutlet weak var dateCreation: UIDatePicker!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    
    @IBOutlet weak var statePicker: UISegmentedControl!
    
    @IBOutlet weak var addButton: UIButton!
    
    let model: RealmListOfTasks = RealmListOfTasks()
    
    var task: Task?
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        descriptTextView.isHidden = false
        descriptTextView.isEditable = true
        descriptTextView.layer.borderWidth = 0.5
        descriptTextView.layer.borderColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        
        if task == nil {
            statePicker.isHidden = true
            addButton.isHidden = false
            
            titleTextField.isEnabled = true
            descriptTextView.isEditable = true
            dateCreation.date = NSDate(timeIntervalSinceNow: 0) as Date
            deadlinePicker.isEnabled = true
        } else {
            statePicker.isHidden = false
            statePicker.isEnabled = true
            statePicker.selectedSegmentIndex = task!.status

            addButton.isHidden = true
            
            titleTextField.isEnabled = false
            descriptTextView.isEditable = false
            deadlinePicker.isEnabled = false
            titleTextField.text = task!.title
            descriptTextView.text = task!.descript
            dateCreation.date = task!.dateOfCreation as Date
            deadlinePicker.date = (task!.deadline as Date)
        }
    }
    
    @IBAction func changeStatus(_ sender: Any) {
        if task != nil {
            do {
                try model.changeStatus(task: task!, to: statePicker.selectedSegmentIndex)
            } catch TasksError.wrongData(let title, let message) {
                makeAlert(title: title, message: message)
            } catch {
                print("empty catch")
            }
        }
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        do {
            let taskTitle = titleTextField.text
            let taskDescription = descriptTextView.text
            let taskDeadline = deadlinePicker.date as NSDate
            let taskCreation = dateCreation.date as NSDate
            let task = Task(title: taskTitle ?? "", descript: taskDescription ?? "", dateOfCreation: taskCreation, deadline: taskDeadline)
            
            try model.add(task: task)
            SPAlert.present(title: "", preset: .done)
        }
           
        catch TasksError.wrongData(let title, let message) {
            makeAlert(title: title, message: message)
        }
           
        catch {
            print("empty catch")
        }
    }
}
