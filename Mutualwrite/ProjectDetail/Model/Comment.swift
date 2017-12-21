//
//  Comment.swift
//  Mutualwrite
//
//  Created by Sritongsuk on 20/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var userID: Int
    var CommentText: String
    init(userID: Int , comment: String) {
        self.userID = userID
        self.CommentText = comment
    }
}
