//
//  ReusableId.swift
//  TestSlim
//
//  Created by sasawat sankosik on 10/29/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit

public protocol ReuseblePopup {
  static var nibName: String { get }
}
public extension ReuseblePopup {
  static var nibName: String {
    return String(describing: self)
  }
}





