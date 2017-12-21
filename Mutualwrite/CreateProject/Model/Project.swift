//
//  Project.swift
//  Mutualwrite
//
//  Created by Sritongsuk on 21/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

class Project: NSObject {
    var authorAdmin: String?
    var image: String?
    var memberAge: String?
    var memberJoin: String?
    var memberLimit: String?
    var plotContent: String?
    var title: String?
//    init(authorAdmin: String , image: UIImage , memberAge: String , memberJoin: String , memberLimit: String , plotContent: String , title: String) {
//        self.authorAdmin = authorAdmin
//        self.image = image
//        self.memberAge = memberAge
//        self.memberJoin = memberJoin
//        self.memberLimit = memberLimit
//        self.plotContent = plotContent
//        self.title = title
//    }
    override init() {
        super.init()
    }
    
    class func getProjectArray( withDataSnapshot data: [String: String] ) -> Project {
        let project = Project()
        if let title = data["title"] as String! ,
//            let authorAdmin = data["authorAdmin"] as String! ,
//            let image = data["image"] as String! ,
//            let memberAge = data["memberAge"] as String! ,
//            let memberJoin = data["memberJoin"] as String! ,
//            let memberLimit = data["memberLimit"] as String! ,
            let plotContent = data["plotContent"] as String!
        {
            
            
            project.title = title
            project.plotContent = plotContent
        }
        return project
    }
}
