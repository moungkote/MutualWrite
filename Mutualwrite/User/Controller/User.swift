//
//  User.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import RealmSwift

enum LoginType: Int {
  case facebook = 0
  case google = 1
  case email = 2
}

class UserData: Object {
    
  @objc dynamic var userName: String = ""
  @objc dynamic var userId: String = ""
  @objc dynamic var email: String = ""
  @objc dynamic var profileURL = ""
  @objc dynamic var age: Int = 0
  @objc dynamic var birthDate = ""
  
  override static func primaryKey() -> String? {
    return "userId"
  }
  
//  lazy var userRef = {
//    Database.database().reference().child("Users")
//  }()
//
  
  static func saveLoginUser(with value: [String: Any]) {
    
    let attribute = value
    
    do {
      let realm = try Realm()
      try realm.write {
        
        let user = UserData()
        user.userId = attribute["userId"] as! String
        UserDefaults.standard.set(user.userId, forKey: "userId")
        user.userName = attribute["userName"] as! String
        user.email = attribute["email"] as! String
        user.profileURL = attribute["profileURL"] as! String
        user.age = attribute["age"] as! Int
        user.birthDate = attribute["birthDate"] as! String
        realm.add(user)
      }
      
    } catch {
      print(error.localizedDescription)
    }
  }
  
//  static func saveLoginUser(with snapshot: DataSnapshot) {
//
//    let attribute = snapshot.value as! [String: Any]
//
//    do {
//      let realm = try Realm()
//      try realm.write {
//
//        let user = UserData()
//        user.userId = attribute["userId"] as! String
//        user.userName = attribute["userName"] as! String
//        user.email = attribute["email"] as! String
//        user.profileURL = attribute["profileURL"] as! String
//        user.age = attribute["age"] as! Int
//        user.birthDate = attribute["birthDate"] as! String
//      }
//
//    } catch {
//      print(error.localizedDescription)
//    }
//  }
  
  static var shared: UserData? {
    
    do {
      let realm = try Realm()
      if let userId = UserDefaults.standard.string(forKey: "userId") {
          return realm.object(ofType: UserData.self, forPrimaryKey: userId)
      }
      
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }
  
  static var isLogedin: Bool {
    return shared != nil
  }
}
