//
//  ProjectRequirementsViewController.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import WSTagsField
//import RangeSeekSlider

class ProjectRequirementsViewController: UIViewController {

  //@IBOutlet weak var rangeSlider: RangeSeekSlider!
  @IBOutlet weak var memberLimitTextField: UITextField!
    
    var project: Project?
    var tags = [WSTag]()
    var categories = [Category]()
    
    lazy var novelsRef: DatabaseReference = Database.database().reference().child("Novels")
    lazy var storageRef: StorageReference = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func publish(_ sender: UIBarButtonItem) {
        
//        project?.memberLimit = memberLimitTextField.text ?? "0")
        if let project = self.project {
            //Have novel image
            if let novelImage = project.image {
                self.uploadMedia(withImage: novelImage, completion: { (imageUrl) in
                  let itemRef = self.novelsRef.child(project.id!)
                  
                    var object = [String: Any]()
                    object["id"] = project.id
                    object["tags"] = self.tags.flatMap({ (tag) -> String? in
                      return tag.text
                    })
                    object["categories"] = self.categories.flatMap({ $0.name })
                    object["userId"] = project.userId
                    object["image"] = imageUrl
                    //object["memberAge"] = String(project.memberAge!)
                    object["memberJoin"] = project.memberJoin
                    object["memberLimit"] = self.memberLimitTextField.text
                    object["plotContent"] = String(project.plotContent!)
                    object["title"] = String(project.title!)
                    //object["minAge"] = self.rangeSlider.selectedMinValue
                    //object["maxAge"] = self.rangeSlider.selectedMaxValue
                    
                    itemRef.setValue(object, withCompletionBlock: { (_, ref) in
                    var value = [String: Any]()
                    value["userId"] = self.project?.userId
                    ref.child("members").child(self.project!.userId!).setValue(value)
                  })
            
                  
                })
            }
            //Not have novel image
            else{
                let itemRef = self.novelsRef.child(project.id!)
                var object = [String: Any]()
                object["id"] = project.id
                object["tags"] = self.tags.flatMap({ (tag) -> String? in
                  return tag.text
                })
                object["categories"] = self.categories.flatMap({ $0.name })
              
                object["userId"] = project.userId
                //            object["image"] = project.image
                //            object["memberAge"] = String(project.memberAge!)
                object["memberJoin"] = project.memberJoin
                //object["memberLimit"] = String(project.memberLimit!)
                object["plotContent"] = String(project.plotContent!)
                object["title"] = String(project.title!)
              
              itemRef.setValue(object, withCompletionBlock: { (_, ref) in
                var value = [String: Any]()
                value["userId"] = self.project?.userId
                ref.child("members").child(self.project!.userId!).setValue(value)
              })
            }
        }
    }
    
    func uploadMedia(withImage image: UIImage , completion: @escaping (_ url: String?) -> Void)  {
        guard let imageData = UIImageJPEGRepresentation(image, 1.0) else { return }
        let imagePath = "\(arc4random_uniform(100)).jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.child(imagePath).putData(imageData, metadata: metadata, completion: { (metadata, error) in
            if error != nil {
                print(error!)
                completion(nil)
            }
            else{
                completion(metadata?.downloadURL()?.absoluteString)
            }
        })
    }
}
