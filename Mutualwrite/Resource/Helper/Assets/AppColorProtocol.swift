//
//  AppColorProtocol.swift
//  Template2017
//
//  Created by sasawat sankosik on 9/1/18.
//  Copyright © 2018 ssankosik. All rights reserved.
//

import UIKit

protocol AppColorProtocol {
  var color: UIColor { get }
  var cgColor: CGColor { get }
  func color(alpha: CGFloat) -> UIColor
  func color(alpha: CGFloat) -> CGColor
  
}
extension AppColorProtocol where Self: RawRepresentable, Self.RawValue == String {
  
  var color: UIColor {
    if rawValue == "" { return UIColor.clear }
    return UIColor(hexString: rawValue)
  }
  
  var cgColor: CGColor {
    if rawValue == "" { return UIColor.clear.cgColor }
    return UIColor(hexString: rawValue).cgColor
  }
  
  func color(alpha: CGFloat) -> UIColor {
    if rawValue == "" { return UIColor.clear }
    return UIColor(hexString: rawValue).withAlphaComponent(CGFloat(alpha))
  }
  
  func color(alpha: CGFloat) -> CGColor {
    if rawValue == "" { return UIColor.clear.cgColor }
    return UIColor(hexString: rawValue).withAlphaComponent(CGFloat(alpha)).cgColor
  }
  
}
