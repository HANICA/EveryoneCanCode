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
    
    @IBOutlet weak var nameLabel: AccessLabel!
    
    @IBOutlet weak var programLabel: AccessLabel!
    
    @IBOutlet weak var cohortLabel: AccessLabel!
    
    @IBOutlet weak var courseLabel: AccessLabel!
    
    @IBOutlet weak var notesLabel: AccessLabel!
    
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
            
            if (self.notesLabel.text?.isEmpty)! {
                self.notesLabel.accessibilityHint = "Notes are empty."
                self.notesLabel.accessibilityLabel = "Notes label"
            }
            
            self.personsImageView.accessibilityTraits = UIAccessibilityTraitImage //1
            self.personsImageView.accessibilityLabel = "Portrait of \(currentStudent.firstname) \(currentStudent.lastname)"//2
            
            self.nameLabel.accessibilityLabel = "\(currentStudent.firstname) \(currentStudent.lastname)"
            self.courseLabel.accessibilityLabel = "Course: \(currentStudent.course)"
            self.cohortLabel.accessibilityLabel = "Cohort:\(currentStudent.cohort)"
            self.notesLabel.accessibilityLabel = currentStudent.notes
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class AccessLabel : UILabel {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

extension AccessLabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.isAccessibilityElement = true
    }
}




