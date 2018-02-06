//
//  AppImage.swift
//  Tutor
//
//  Created by Mosz on 16/12/17.
//  Copyright © 2017 Mosz. All rights reserved.
//

import Foundation
enum AppImage: String, AppAssetProtocol {
  
  case banner_raw
  
  var name: String {
    return "img_\(self.rawValue)"
  }
}
