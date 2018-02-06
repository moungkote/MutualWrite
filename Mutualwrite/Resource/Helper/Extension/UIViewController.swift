//
//  UIViewController.swift
//  TestSlim
//
//  Created by sasawat sankosik on 10/29/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit

extension UIViewController {
  
  static var top: UIViewController? {
    get {
      return topViewController()
    }
  }
  
  static var root: UIViewController? {
    get {
      return UIApplication.shared.delegate?.window??.rootViewController
    }
  }
  
  static func topViewController(from viewController: UIViewController? = UIViewController.root) -> UIViewController? {
    if let tabBarViewController = viewController as? UITabBarController {
      return topViewController(from: tabBarViewController.selectedViewController)
    } else if let navigationController = viewController as? UINavigationController {
      return topViewController(from: navigationController.visibleViewController)
    } else if let presentedViewController = viewController?.presentedViewController {
      return topViewController(from: presentedViewController)
    } else {
      return viewController
    }
  }
  
}
