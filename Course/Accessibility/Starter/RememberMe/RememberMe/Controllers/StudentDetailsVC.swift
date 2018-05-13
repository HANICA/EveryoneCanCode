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
        
        if let currentStudent = student {
           // implement the code to get the detail VC working here
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// Some helper stuff for Accessibility

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




