//
//  addCommentPopupViewController.swift
//  Mutualwrite
//
//  Created by Sritongsuk on 20/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

protocol AddCommentDelegate: class {
    func addComment(comment: String?, user: String)
}

class addCommentPopupViewController: UIViewController {
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBAction func post(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            
            let user = "1234"
            self.delegate?.addComment(comment: self.commentTextView.text, user: user)
        })
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    weak var delegate: AddCommentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissPopup (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.0)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        self.commentTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func viewController() -> addCommentPopupViewController {
        let storyboard = UIStoryboard(name: "NovelsProject", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "addCommentPopupViewControllerID") as! addCommentPopupViewController
    }
    
    @objc func dismissPopup (_ sender: UITapGestureRecognizer) {
        self.commentTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

}
