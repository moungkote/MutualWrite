//
//  ReusableCell.swift
//  TestSlim
//
//  Created by sasawat sankosik on 11/4/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit

public protocol ReusableCell {
  static var reuseId: String { get }
}

public extension ReusableCell {
  static var reuseId: String {
    return String(describing: self)
  }
}
