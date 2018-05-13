//
//  PersonsModel.swift
//  RememberMe
//
//  Created by J.A. Korten on 13-05-18.
//  Copyright © 2018 HAN University of Applied Sciences. All rights reserved.
//

import Foundation

let personsModel = PersonsModel.shared

public class PersonsModel {
    
    static let shared = PersonsModel()
    var students : [Student]
    
    init() {
        students = []
    }
}

extension PersonsModel {
    
    func addCustormStudentsToModel() {
        
        // Courses
        let courseMAD = "Mobile Application Development"
        let courseISD = "Introduction to Swift Development"
        let courseECC = "Everyone Can Code"
        
        let bachelorICT_SD = "Bachelor ICT, Software Dev."
        let bachelorICT_WD = "Bachelor ICT, Web Development"
        let bachelorCMD = "Communication and Media Design"

        let student1 = Student(id: 1, firstname: "Jim", lastname: "Cook", cohort: 2015, image: "student1.png", program: bachelorICT_SD, course: courseMAD, notes: "")
        
        let student2 = Student(id: 2, firstname: "Martin", lastname: "Bob", cohort: 2017, image: "student2.png", program: bachelorCMD, course: courseISD, notes: "")
        
        let student3 = Student(id: 3, firstname: "George", lastname: "Fish", cohort: 2017, image: "student3.png", program: bachelorCMD, course: courseECC, notes: "Very lazy student, no matter what they say.")
        
        let student4 = Student(id: 4, firstname: "Toby", lastname: "Martin", cohort: 2017, image: "student4.png", program: bachelorCMD, course: courseECC, notes: "")
        
        let student5 = Student(id: 5, firstname: "Jonathan", lastname: "Ivy", cohort: 2017, image: "student5.png", program: bachelorICT_WD, course: courseECC, notes: "Has no clue about Apple Swift programming")
        
        let student6 = Student(id: 6, firstname: "Lisa", lastname: "Jobs", cohort: 2015, image: "student6.png", program: bachelorICT_WD, course: courseMAD, notes: "Excellent student. Goal of final app will be to connect landlords and students.")

        let student7 = Student(id: 7, firstname: "James", lastname: "Wozniak", cohort: 2015, image: "student7.png", program: bachelorICT_SD, course: courseECC, notes: "")

        let student8 = Student(id: 8, firstname: "Mike", lastname: "Douglas", cohort: 2015, image: "student8.png", program: bachelorICT_SD, course: courseECC, notes: "")

        let student9 = Student(id: 9, firstname: "Lois", lastname: "Lane", cohort: 2015, image: "student9.png", program: bachelorCMD, course: courseISD, notes: "Has a love for spiders.")

        let student10 = Student(id: 10, firstname: "John", lastname: "Doe", cohort: 2015, image: "student10.png", program: bachelorCMD, course: courseISD, notes: "Has a spare time job as morgue assistent.")
        
        self.students.append(student1)
        self.students.append(student2)
        self.students.append(student3)
        self.students.append(student4)
        self.students.append(student5)
        self.students.append(student6)
        self.students.append(student7)
        self.students.append(student8)
        self.students.append(student9)
        self.students.append(student10)

    }
}
