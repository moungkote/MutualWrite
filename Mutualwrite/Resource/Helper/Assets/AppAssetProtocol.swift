//
//  AppAsset.swift
//  TestSlim
//
//  Created by sasawat sankosik on 11/4/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit
protocol AppAssetProtocol {
  var name: String { get }
  var image: UIImage { get }
  func image(_ overlayColor: AppColor) -> UIImage
}
extension AppAssetProtocol {

  var image: UIImage {
    return UIImage(named: name) ?? UIImage()
  }
  
  func image(_ overlayColor: AppColor) -> UIImage {
    let image = UIImage(named: name)
    if let newColor = image?.overlay(color: overlayColor.color) {
      return newColor
    }
    return image ?? UIImage()
  }
  
}
