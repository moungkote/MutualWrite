//
//  UIButton.swift
//  Template2017
//
//  Created by sasawat sankosik on 4/1/18.
//  Copyright © 2018 ssankosik. All rights reserved.
//

import UIKit

//MARK: HILIGHT BACKGROUND
extension UIButton {
  private func imageWithColor(color: UIColor) -> UIImage? {
    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
  
  func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
    let img = imageWithColor(color: color)
    self.setBackgroundImage(img, for: state)
  }
}
