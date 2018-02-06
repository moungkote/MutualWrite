//
//  LoginViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 17/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    var dict : [String : AnyObject]!
  var params: String! = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    LoginWithEmail()
  }
  
  private func LoginWithEmail() {
    
//    Auth.auth().signIn(withEmail: "hjhjhj@mail.com", password: "12345") { (user, error) in
//
//      print("error : \(error?.localizedDescription)")
//      print("user info : \(user?.email)")
//    }
    
    Auth.auth().createUser(withEmail: "test@mail.com", password: "12345678") { (user, error) in
      //print("error : \(error?.localizedDescription)")
      //print("user info : \(user?.email)")
    }
  }
  
  private func handlerUser(user: User, loginType: LoginType) {
    
    let userRef = Database.database().reference().child("Users")
    
    userRef.child(user.uid).observe(.value) { (snap) in
      
      if snap.hasChildren() {
        
        // Present the main view
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController")
        let windows = UIApplication.shared.keyWindow
        
        UIView.transition(with: windows!, duration: 0.4, options: .transitionCrossDissolve, animations: {
          
          windows?.rootViewController = homeVC
          windows?.makeKeyAndVisible()
          
        }, completion: nil)
        
      }else {
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpWithAccountViewController") as! SignUpWithAccountViewController
        vc.loginType = loginType
        vc.userFromAccount = user
        self.present(vc, animated: true, completion: nil)
      }
      
    }


  }
  
  @IBAction func facebookLogin(sender: UIButton) {
    
    let fbLoginManager = FBSDKLoginManager()
    fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
      if let error = error {
        print("Failed to login: \(error.localizedDescription)")
        return
      }
      
      guard let accessToken = FBSDKAccessToken.current() else {
        print("Failed to get access token")
        return
      }
      
      let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
      
      // Perform login by calling Firebase APIs
      Auth.auth().signIn(with: credential, completion: { (user, error) in
        if let error = error {
          
          print("Login error: \(error.localizedDescription)")
          let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
          let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(okayAction)
          self.present(alertController, animated: true, completion: nil)

          return
        }
        
        if let user = Auth.auth().currentUser {
          self.handlerUser(user: user, loginType: .facebook)
        }

      })
      
    }
  }
}

