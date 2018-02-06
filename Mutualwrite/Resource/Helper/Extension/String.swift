//
//  String.swift
//  TestSlim
//
//  Created by sasawat sankosik on 10/29/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit

extension String {
  static func className(_ aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
  } 
  
}

extension String {
  
  subscript (i: Int) -> Character {
    return self[self.index(self.startIndex, offsetBy: i)]
  }
  
  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }
  
  subscript (r: Range<Int>) -> String {
    let start = index(startIndex, offsetBy: r.lowerBound)
    let end = index(startIndex, offsetBy: r.upperBound)
    return String(self[start..<end])
  }
  
  subscript (r: ClosedRange<Int>) -> String {
    let start = index(startIndex, offsetBy: r.lowerBound)
    let end = index(startIndex, offsetBy: r.upperBound)
    return String(self[start...end])
  }
}
