//
//  NotificationViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 21/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NotificationViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var requests = [Request]()
  lazy var requestRef = Database.database().reference().child("Requests")
  lazy var novelRef = Database.database().reference().child("Novels")
  
  private lazy var user = { UserData.shared }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let user = UserData.shared
        print(user?.userId as Any)
        self.fetchRequest()
    }
  
  private func fetchRequest() {
    
    if let user = UserData.shared {
        requestRef.queryOrdered(byChild: "projectOwnerUserId").queryEqual(toValue: user.userId).observe(.value, with: { (snap) in
            //print(snap.value as Any)
        let snaps = snap.children.allObjects as! [DataSnapshot]
        self.requests = snaps.flatMap({ Request.init(snap: $0) })
        self.tableView.reloadData()
        
      })
    }
    
  }

  
}

extension NotificationViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return requests.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "RequestProjectTableViewCell") as! RequestProjectTableViewCell
    cell.delegate = self
    cell.setCell(request: requests[indexPath.row])
    return cell
    
  }
}
extension NotificationViewController: RequestProjectTableViewCellDelegate {
  
  func requestProject(didAccept request: Request) {
    var value = [String: Any]()
    value["userId"] = request.userId
    novelRef.child("\(request.projectId)/members").child("\(request.userId)").setValue(value) { (error, ref) in
      
      self.requestRef.child(request.requestId).setValue(nil)
      
    }
  }
  
  func requestProject(didDecline request: Request) {
    var value = [String: Any]()
    value["userId"] = user?.userId
    novelRef.child("\(request.projectId)/members").child("\(user!.userId)").setValue(nil) { (error, ref) in
      
      self.requestRef.child(request.requestId).setValue(nil)
      
    }
  }
}
