//
//  NovelsProjectViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 20/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NovelsProjectViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var plotType: PlotType!
    private lazy var plotItemRef = Database.database().reference().child("Plots").child(self.project.id!).child(self.plotType.rawValue)
    var plotItem: PlotItem?
    var project: Project!
    var commentArray = [Comment]() {
        didSet {
            setHighlightComment()
        }
    }
    
    private lazy var novelsRef: DatabaseReference = Database.database().reference().child("Novels")
    private var novlesRefHandle: DatabaseHandle?
    lazy var user: UserData = { return UserData.shared }()!
    
    deinit {
        print("Deinitialized class : \(type(of: self))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNovels()
        self.setActionMenu()
        self.getComment()
        self.setContent(content: plotItem?.content)
        self.observeContent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let refHandle = novlesRefHandle {
            novelsRef.removeObserver(withHandle: refHandle)
        }
    }
    
    private func observeContent() {
        
        self.plotItemRef.observe(.value) { (snap) in
            
            print(snap.value)
            let value = snap.value as? [String: Any]
            if let contentUpdate = value?["content"] as? String {
                self.setContent(content: contentUpdate)
            }
            
        }
    }
    
    private func setContent(content: String?) {
        contentTextView.text = content
        self.setHighlightComment()
    }
    
    private func getComment() {
        
//        self.novlesRefHandle = novelsRef.child(self.project.id!).child("comments").observe(.value) { (data) in
//
//            let dataSnapshotArray = data.children.allObjects as! [DataSnapshot]
//            print(dataSnapshotArray)
//            self.commentArray = dataSnapshotArray.map({ (data) -> Comment in
//
//                return Comment.init(withDataSnapshot: data)
//            })
//        }
        
        self.plotItemRef.child("comments").observe(.value) { (data) in
            
            let dataSnapshotArray = data.children.allObjects as! [DataSnapshot]
            print(dataSnapshotArray)
            self.commentArray = dataSnapshotArray.map({ (data) -> Comment in
                return Comment.init(withDataSnapshot: data)
            })
        }
    }
    
    private func setHighlightComment() {
        
        let attribute = NSMutableAttributedString(string: contentTextView.text)
        for comment in commentArray {
            
            let color = UIColor.gray
            attribute.addAttribute(NSAttributedStringKey.backgroundColor, value: color, range: comment.hightLightRange!)
            
            let actionAttribute = [ NSAttributedStringKey.action: comment]
            attribute.addAttributes(actionAttribute, range: comment.hightLightRange!)
            
            // Add tap gesture recognizer to Text View
            let tap = UITapGestureRecognizer(target: self, action: #selector(highlightTap(_:)))
            contentTextView.addGestureRecognizer(tap)
            
        }
        
        contentTextView.attributedText = attribute
    }
    
    //ViewController init
    func viewController() -> NovelsProjectViewController {
        let storyboard = UIStoryboard(name: "NovelsProject", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "NovelsProjectViewControllerID") as! NovelsProjectViewController
    }
    
    func settingViewController(project: Project) {
        self.project = project
    }
    
    //require load view
    
    func loadNovels() {
        self.titleLabel.text = self.project.title
        self.contentTextView.text = self.project.plotContent
        self.setHighlightComment()
    }
    
    func setActionMenu() {
        let addCommentMenuItem = UIMenuItem(title: "Add Comment", action: #selector(presentAddComment))
        UIMenuController.shared.menuItems = [addCommentMenuItem]
    }
    
    // Mark: - Action
    
    @objc func presentAddComment() {
        if let range = self.contentTextView.selectedTextRange, let selectedText = contentTextView.text(in: range) {
            print("selectedText: \(selectedText)")
            print("start range: \(range.start)")
            print("end range: \(range.end)")
        }
        let vc = addCommentPopupViewController().viewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func highlightTap(_ sender: UITapGestureRecognizer) {
        
        let textView = sender.view as! UITextView
        
        let layoutManager = textView.layoutManager
        
        // location of tap in myTextView coordinates and taking the inset into account
        var location = sender.location(in: textView)
        location.x -= textView.textContainerInset.left;
        location.y -= textView.textContainerInset.top;
        
        // character index at tap location
        let characterIndex = layoutManager.characterIndex(for: location, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        // if index is valid then do something.
        if characterIndex < textView.textStorage.length {
            
            // print the character index
            print("character index: \(characterIndex)")
            
            // print the character at the index
            let myRange = NSRange(location: characterIndex, length: 1)
            let substring = (textView.attributedText.string as NSString).substring(with: myRange)
            print("character at index: \(substring)")
            
            // check if the tap location has a certain attribute
            let attributeName = NSAttributedStringKey.action
            let attributeValue = textView.attributedText.attribute(attributeName, at: characterIndex, effectiveRange: nil) as? Comment
            if let value = attributeValue {
                print("You tapped on \(attributeName) and the value is: \(value.comment ?? "")")
            }
            
        }
    }
    
}

extension NovelsProjectViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.plotItemRef.child("content").setValue(textView.text)
        self.plotItemRef.child("editByUserId").setValue(user.userId)
        self.plotItemRef.child("editByUserImageURL").setValue(user.profileURL)
        self.plotItemRef.child("editByUserName").setValue(user.userName)
        self.plotItemRef.child("lastUpdate").setValue(dateFormatter.string(from: Date()))
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        print("replace text : \(text) in \(range)")
        
        //
        for commentItem in commentArray {
            
            if range.location < commentItem.hightLightRange!.location {
                
                var object = [String: Any]()
                object["id"] = commentItem.id
                object["userId"] = self.user.userId
                object["comment"] = commentItem.comment
                var range = commentItem.hightLightRange!
                object["location"] = range.location + 1
                object["length"] = range.length
                
                self.plotItemRef.child("comments").child(commentItem.id!).setValue(object)
            }
        }
        return true
    }
    
}

extension NovelsProjectViewController: AddCommentDelegate {
    
    func addComment(comment: String?, user: String) {
        
        var object = [String: Any]()
        let id = self.plotItemRef.childByAutoId().key  //Important when you access comment after this time
        object["id"] = id
        object["userId"] = user
        object["comment"] = comment
        let range = contentTextView.selectedRange
        object["location"] = range.location
        object["length"] = range.length
        //novelsRef.child(project.id!).child("comments").child(id).setValue(object)
        
        self.plotItemRef.child("comments").child(id).setValue(object)
    }
}

