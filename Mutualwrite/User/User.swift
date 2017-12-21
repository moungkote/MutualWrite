//
//  User.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import Foundation

struct User {
    
    var userName = "Mean"
    
    static var shared: User? {
        return User.init()
    }
}
