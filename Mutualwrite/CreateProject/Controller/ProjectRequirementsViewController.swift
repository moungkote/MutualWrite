//
//  ProjectRequirementsViewController.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProjectRequirementsViewController: UIViewController {

    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var memberLimitTextField: UITextField!
    
    var project: Project?
    
    lazy var novelsRef: DatabaseReference = Database.database().reference().child("Novels")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func publish(_ sender: UIBarButtonItem) {
        
//        project?.memberLimit = memberLimitTextField.text ?? "0")
        if let project = self.project {
            let itemRef = novelsRef.childByAutoId()
            var object = [String: String]()
            object["userID"] = String(0)
            object["image"] = nil
//            object["memberAge"] = String(project.memberAge!)
            object["memberJoin"] = project.memberJoin
//            object["memberLimit"] = String(project.memberLimit!)
            object["plotContent"] = String(project.plotContent!)
            object["title"] = String(project.title!)
            itemRef.setValue(object)
        }
    }
    

}
