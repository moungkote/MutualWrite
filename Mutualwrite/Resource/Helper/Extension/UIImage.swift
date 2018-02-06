//
//  UIImage.swift
//  TestSlim
//
//  Created by sasawat sankosik on 11/4/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit

extension UIImage {
  func imageWithInsets(insetDimen: CGFloat) -> UIImage {
    return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
  }
  
  func imageWithInset(insets: UIEdgeInsets) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(
      CGSize(width: self.size.width + insets.left + insets.right,
             height: self.size.height + insets.top + insets.bottom), false, self.scale)
    let origin = CGPoint(x: insets.left, y: insets.top)
    self.draw(at: origin)
    let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return imageWithInsets!
  }
  
  func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
    //Calculate the size of the rotated view's containing box for our drawing space
    let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
    rotatedViewBox.transform = t
    let rotatedSize: CGSize = rotatedViewBox.frame.size
    //Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap: CGContext = UIGraphicsGetCurrentContext()!
    //Move the origin to the middle of the image so we will rotate and scale around the center.
    bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
    //Rotate the image context
    bitmap.rotate(by: (degrees * CGFloat.pi / 180))
    //Now, draw the rotated/scaled image into the context
    bitmap.scaleBy(x: 1.0, y: -1.0)
    bitmap.draw(cgImage!, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
  }
  
  func overlay(color: UIColor) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
    let context = UIGraphicsGetCurrentContext()
    
    color.setFill()
    
    context!.translateBy(x: 0, y: self.size.height)
    context!.scaleBy(x: 1.0, y: -1.0)
    
    context!.setBlendMode(CGBlendMode.colorBurn)
    let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    context!.draw(self.cgImage!, in: rect)
    
    context!.setBlendMode(CGBlendMode.sourceIn)
    context!.addRect(rect)
    context!.drawPath(using: CGPathDrawingMode.fill)
    
    let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return coloredImage
  }
  
  func updateImageOrientionUpSide() -> UIImage? {
    if self.imageOrientation == .up {
      return self
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
    if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
      UIGraphicsEndImageContext()
      return normalizedImage
    }
    UIGraphicsEndImageContext()
    return nil
  }
  
}

