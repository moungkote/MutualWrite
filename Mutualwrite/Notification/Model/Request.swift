//
//  Request.swift
//  Mutualwrite
//
//  Created by MSlagger on 21/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Request {
  
  var requestId: String
  var userId: String
  var userName: String
  var profileURL: String
  var projectId: String
  var projectName: String
  var projectOwnerUserId: String
  
  init(snap: DataSnapshot) {
    
    let data = snap.value as! [String: Any]
    self.requestId = data["requestId"] as! String
    self.userId = data["userId"] as! String
    self.userName = data["userName"] as! String
    self.profileURL = data["profileURL"] as! String
    self.projectId = data["projectId"] as! String
    self.projectName = data["projectName"] as! String
    self.projectOwnerUserId = data["projectOwnerUserId"] as! String
  }
}
