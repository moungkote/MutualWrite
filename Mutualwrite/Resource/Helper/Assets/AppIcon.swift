//
//  AppIcon.swift
//  TestSlim
//
//  Created by sasawat sankosik on 11/4/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit
enum AppIcon: String, AppAssetProtocol {
  case none
  case alert
  case question
  case correct
  case wrong
  case delete
  case warnning
  
  //Nav
  case nav_back
  case nav_close
  
  //TabBar
  case home
  case home_1
  case find
  case find_1
  case photo
  case photo_1
  var name: String {
    return "ic_\(self.rawValue)"
  }
}
