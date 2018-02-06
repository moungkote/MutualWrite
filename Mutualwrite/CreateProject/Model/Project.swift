//
//  Project.swift
//  Mutualwrite
//
//  Created by Sritongsuk on 21/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Project: NSObject {
  
  var id: String?
  var image: UIImage?
  var title: String?
  var imageURL: String?
  var plotContent: String?
  var userId: String?
  var createdDate: String?
  var members: [String]?
  var requests: [String]?
  
  var authorAdmin: String?
  var memberAge: String?
  var memberJoin: String?
  var memberLimit: String?
  var projectOwnerUserId : String?
  
  
  
  override init() {
    super.init()
  }
  
  init(withDataSnapshot snapshot: DataSnapshot) {
    let attribute = snapshot.value as! [String: Any]
    self.id = attribute["id"] as? String
    self.title = attribute["title"] as? String
    self.imageURL = attribute["image"] as? String
    self.plotContent = attribute["plotContent"] as? String
    self.userId = attribute["userId"] as? String
    self.authorAdmin = attribute["authorAdmin"] as? String
    self.createdDate = attribute["createdDate"] as? String
    self.projectOwnerUserId = attribute["projectOwnerUserId"] as? String
    
    let requestsSnapshot = snapshot.childSnapshot(forPath: "requests")
    var snapshotArray = requestsSnapshot.children.allObjects as! [DataSnapshot]
    self.requests = snapshotArray.flatMap({ $0.value as? String })
    
    let membersSnapshot = snapshot.childSnapshot(forPath: "members")
    snapshotArray = membersSnapshot.children.allObjects as! [DataSnapshot]
    self.members = snapshotArray.flatMap({ $0.value as? String })
    
    
  }
  
  /*
   
   class func getProjectArray( withDataSnapshot data: [String: String] ) -> Project {
   let project = Project()
   if let title = data["title"] as String! ,
   //            let authorAdmin = data["authorAdmin"] as String! ,
   let image = data["image"] as String! ,
   //            let memberAge = data["memberAge"] as String! ,
   //            let memberJoin = data["memberJoin"] as String! ,
   //            let memberLimit = data["memberLimit"] as String! ,
   let plotContent = data["plotContent"] as String!
   {
   
   project.imageURL = image
   project.title = title
   project.plotContent = plotContent
   }
   return project
   }
   
   */
}
