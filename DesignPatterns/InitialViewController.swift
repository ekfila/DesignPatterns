//
//  InitialViewController.swift
//  DesignPatterns
//
//  Created by Ekaterina Stepanova on 29.06.21.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func AddNew(_ sender: Any) {
        performSegue(withIdentifier: "AddNewTask", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewTask" {
            let vc = segue.destination as! AddNewViewController
            vc.task = nil
            //Status.shared.state = .add
        }
    }
    
}
