//
//  StudentsTableViewController.swift
//  RememberMe
//
//  Created by J.A. Korten on 13-05-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {

    @IBOutlet var tableview: UITableView!
    
    fileprivate let reuseIdentifier = "PersonCellWithImage"
    fileprivate let detailSegueIdentifier = "detailStudentSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.estimatedRowHeight = 100
        self.tableview.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0 // needs to become 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 // personsModel.students.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StudentTableViewCell
            // Note: force unwrap, normally you want to do an if let but cell needs to be something, if your reuse identifier is incorrect your app will crash
        
            if let person = personsModel.students[indexPath.row] as? Student {
                cell.applyAccessibility(person)
                cell.imageView?.image = UIImage(named: person.image)
                cell.nameLabel.text = person.firstname + " " + person.lastname
            }
        return cell
    }*/
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0 // be careful with magic numbers.
        //better: return UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == detailSegueIdentifier,
            let destination = segue.destination as? StudentDetailsVC
        {
            // A. retrieve current student from model
            // B. pass the 'student' instance to the receiving detail VC
        }
    }

}
