//
//  CreateProjectViewController.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateProjectViewController: UIViewController {
    
    @IBOutlet weak var projectButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    lazy var createNovelsProject: DatabaseReference = Database.database().reference().child("NovelsProject")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    // MARK : - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? ProjectRequirementsViewController {
            vc.project = sender as? Project
        }
    }
    
    // MARK : - Action
    
    @IBAction func selectImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        
        let project = Project()
        project.authorAdmin = User.shared?.userName
        //project.image = projectButton.currentBackgroundImage
        project.title = titleTextField.text
        project.plotContent = descriptionTextView.text
        
        performSegue(withIdentifier: "projectRequirements", sender: project)
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
