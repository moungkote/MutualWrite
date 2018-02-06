//
//  SignUpWithAccountViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 21/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import RealmSwift

class SignUpWithAccountViewController: UIViewController {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var displayNameTextField: UITextField!
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var birthdateTextField: UITextField!
  
  lazy var userRef = Database.database().reference(withPath: "Users")
  lazy var userId = { self.userFromAccount?.uid ?? userRef.childByAutoId().key }()
  var userFromAccount: User?
  var loginType: LoginType?
  
  override func viewDidLoad() {
        super.viewDidLoad()

        setUser()
    }
  
  private func setUser() {
    
    guard let user = self.userFromAccount else { return }
    if let profileURL = user.photoURL {
      self.profileImageView.af_setImage(withURL: profileURL)
    }
    self.emailTextField.text = user.email
    self.displayNameTextField.text = user.displayName
  }
  
  private func ageCalculator() -> Int? {
    
    let dateFormattter = DateFormatter()
    dateFormattter.locale = Locale(identifier: "en_US")
    dateFormattter.dateFormat = "dd/MM/yyyy"
    
    if let date = dateFormattter.date(from: self.birthdateTextField.text!) {
      
      let calendar = Calendar.current
      let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
      let age = ageComponents.year!
      return age
    }
    return nil
    
  }
  
  private func uploadProfileImage() {
    
    guard let image = self.profileImageView.image else { return }
    let storageRef = Storage.storage().reference(withPath: userId)
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    let data = UIImageJPEGRepresentation(image, 1.0)
    storageRef.putData(data!, metadata: metadata) { (metadata, error) in
      
      if let error = error {
        print(error.localizedDescription)
      }else {
        
        if let url = metadata?.downloadURL() {
          let value = ["profileImage": url.absoluteString]
          self.userRef.child(self.userId).setValue(value, withCompletionBlock: { (error, ref) in
            
            let user = UserData.shared
            do {
              let realm = try Realm()
              try realm.write {
                user?.profileURL = url.absoluteString
                realm.add(user!, update: true)
              }
            }catch {
              print(error.localizedDescription)
            }
            
          })
        }
      }
    }
    
  }
  
  private func setTabbarToRootViewController() {
    
    let app = UIApplication.shared.delegate as! AppDelegate
    let windows = app.window!
    
    UIView.transition(with: windows, duration: 0.4, options: .transitionCrossDissolve, animations: {
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let tabbarController = storyboard.instantiateViewController(withIdentifier: "TabbarController")
      windows.rootViewController = tabbarController
      windows.makeKeyAndVisible()
      
    }, completion: nil)
  }
  

  @IBAction func addProfileImage(_ sender: Any) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func register(_ sender: UIButton) {
    
    var value = [String: Any]()
    guard let age = self.ageCalculator() else { print("Cannot serialize date of birth"); return }
    value["age"] = age
    value["userId"] = userId
    value["email"] = emailTextField.text
    value["userName"] = self.displayNameTextField.text
    value["birthDate"] = self.birthdateTextField.text
    value["loginType"] = self.loginType?.rawValue
    
    if userFromAccount?.photoURL == nil{
      self.uploadProfileImage()
    }else {
      value["profileURL"] =  userFromAccount?.photoURL?.absoluteString
    }
    
    self.userRef.child(userId).setValue(value) { (error, ref) in
      
      if let error = error {
        print(error.localizedDescription)
      }else {
        UserData.saveLoginUser(with: value)
        self.setTabbarToRootViewController()
      }
    }
    
  }
  
}

extension SignUpWithAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      self.profileImageView.image = image
    }
  }
}
