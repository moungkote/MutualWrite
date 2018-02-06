//
//  CreateProjectViewController.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase
import WSTagsField
import TTGTagCollectionView

class CreateProjectViewController: UIViewController {
    
    @IBOutlet weak var projectButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var categoryTagView: TTGTextTagCollectionView!
  
  
    typealias Sender = (project: Project, tags: [WSTag])
    lazy var tagsField = WSTagsField()
    lazy var tagRef: DatabaseReference = Database.database().reference().child("Tags")
    lazy var projectId = { self.tagRef.childByAutoId().key }()
  
    lazy var userRef = Database.database().reference(withPath: "Users")
    lazy var userId = { UserData.shared?.userId }()
  
    lazy var createNovelsProject: DatabaseReference = Database.database().reference().child("Novels")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        setTagField()
    }
  
  private func setTagField() {
    
    tagView.layoutIfNeeded()
    tagsField.frame = tagView.bounds
    tagsField.placeholder = "Enter a tag"
    tagView.addSubview(tagsField)
    textFieldEvents()
    
    categoryTagView.alignment = .left
    categoryTagView.scrollDirection = .horizontal
    
  }

    // MARK : - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? ProjectRequirementsViewController {
          let sender = sender as? Sender
            vc.project = sender?.project
          vc.tags = sender!.tags
        }
      if let vc = segue.destination as? SelectCategoriesViewController{
        vc.delegate = self
      }
    }
    
    // MARK : - Action
  
  @IBAction func addCatergories(_ sender: UIButton) {
    
  }
  
    @IBAction func selectImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
 
        let project = Project()
      
        project.userId = userId
        project.id = projectId
        project.image = projectButton.currentBackgroundImage
        project.title = titleTextField.text
        project.plotContent = descriptionTextView.text
      let sender: Sender = (project, tagsField.tags)
        performSegue(withIdentifier: "projectRequirements", sender: sender)
    }

}


extension CreateProjectViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            projectButton.setBackgroundImage(image, for: .normal)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension CreateProjectViewController {
  fileprivate func textFieldEvents() {
    tagsField.onDidAddTag = { _,tag in
      print("DidAddTag")
      
      var value = [String: Any]()
      value["name"] = tag.text
      value["novel"] = self.projectId
      self.tagRef.child(tag.text).setValue(value)
      
    }
    
    tagsField.onDidRemoveTag = { _,_ in
      print("DidRemoveTag")
    }
    
    tagsField.onDidChangeText = { _, text in
      print("onDidChangeText")
    }
    
    tagsField.onDidBeginEditing = { _ in
      print("DidBeginEditing")
    }
    
    tagsField.onDidEndEditing = { _ in
      print("DidEndEditing")
    }
    
    tagsField.onDidChangeHeightTo = { _, height in
      print("HeightTo \(height)")
    }
    
    tagsField.onDidSelectTagView = { _, tagView in
      print("Select \(tagView)")
    }
    
    tagsField.onDidUnselectTagView = { _, tagView in
      print("Unselect \(tagView)")
    }
  }
}

extension CreateProjectViewController:SelectCategoriesViewControllerDelegate{
  
  func didSelectCategory(category: Category) {
    self.categoryTagView.addTag(category.name)
  }

  
}
