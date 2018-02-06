//
//  ReusableController.swift
//  TestSlim
//
//  Created by sasawat sankosik on 11/4/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit

public protocol ReusableController {
  static var reuseId: String { get }
  static var storyboard: UIStoryboard { get }
  static var instantiate: UIViewController? { get }
}

public extension ReusableController {
  static var reuseId: String {
    return String(describing: self)
  }
  static var storyboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }
  static var instantiate: UIViewController? {
    return storyboard.instantiateViewController(withIdentifier: reuseId)
  }
  static var classStoryboard: UIStoryboard {
    let storyboardName = reuseId.replacingOccurrences(of: "Controller", with: "")
    return UIStoryboard(name: storyboardName, bundle: nil)
  }
  static var classInstantiate: UIViewController? {
    return classStoryboard.instantiateViewController(withIdentifier: reuseId)
  }
}
