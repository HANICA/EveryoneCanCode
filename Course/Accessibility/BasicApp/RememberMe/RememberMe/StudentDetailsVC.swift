//
//  ViewController.swift
//  RememberMe
//
//  Created by J.A. Korten on 13-05-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import UIKit

class StudentDetailsVC: UIViewController {
    
    @IBOutlet weak var personsImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var programLabel: UILabel!
    
    @IBOutlet weak var cohortLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    var student : Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let currentStudent = student {
            self.personsImageView.image = UIImage(named: currentStudent.image)
            self.nameLabel.text = "\(currentStudent.firstname) \(currentStudent.lastname)"
            self.courseLabel.text = "Course: \(currentStudent.course)"
            self.cohortLabel.text = "Cohort:\(currentStudent.cohort)"
            self.notesLabel.text = currentStudent.notes
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

