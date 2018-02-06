//
//  WritePlotViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 26/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
import FirebaseDatabase

class WritePlotViewController: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!
    
    private lazy var plotItemRef = Database.database().reference().child("Plots").child(projectId).child(self.plotItem.plotType.rawValue)
    
    var plotItem: PlotItem!
    var projectId: String!
    lazy var user: UserData = { return UserData.shared }()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setContent(content: plotItem.content)
        self.observeContent()
    }

    private func observeContent() {
        
        self.plotItemRef.observe(.value) { (snap) in
            
            //print(snap.value)
            let value = snap.value as! [String: Any]
            if let contentUpdate = value["content"] as? String {
                self.setContent(content: contentUpdate)
            }
            
        }
    }
    
    private func setContent(content: String?) {
        contentTextView.text = content
    }
}

extension WritePlotViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        var value = [String: Any]()
        value["content"] = textView.text
        value["editByUserId"] = user.userId
        value["editByUserImageURL"] = user.profileURL
        value["editByUserName"] = user.userName
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        value["lastUpdate"] = dateFormatter.string(from: Date())
        self.plotItemRef.setValue(value)
    }
}
