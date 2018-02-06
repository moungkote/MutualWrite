//
//  UIView.swift
//  FacialMenApp
//
//  Created by sasawat sankosik on 5/12/17.
//  Copyright © 2017 nofchanwit. All rights reserved.
//

import UIKit

//
//APPERANCE
//
extension UIView {
  func createCornerRadius(radius: CGFloat, corners: UIRectCorner) {
    let maskPathTop = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let shapeLayerTop = CAShapeLayer()
    shapeLayerTop.frame = self.bounds
    shapeLayerTop.path = maskPathTop.cgPath
    self.layer.mask = shapeLayerTop
  }
  
  func cornerRaduis(color: AppColor = .clear, raduis: CGFloat = 2, width: CGFloat = 0.0) {
    layer.borderColor = color.cgColor
    layer.borderWidth = width
    layer.masksToBounds = true
    layer.cornerRadius = raduis
  }
  
  func drowShadow(offset: CGSize = CGSize.zero, raduis: CGFloat = 2, opacity: Float = 0.2) {
    layer.masksToBounds = false
    layer.shadowOffset = offset
    layer.shadowRadius = raduis
    layer.shadowOpacity = opacity
    layer.shadowColor = AppColor.black.cgColor
    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
  
  func clippedDropShadow(offset: CGSize = CGSize.zero, raduis: CGFloat = 2, opacity: Float = 0.2) {
    superview?.viewWithTag(119900)?.removeFromSuperview()
    let shadowView = UIView(frame: frame)
    shadowView.tag = 119900
    shadowView.layer.shadowColor = AppColor.black.cgColor
    shadowView.layer.shadowOffset = offset
    shadowView.layer.masksToBounds = false
    shadowView.layer.shadowOpacity = opacity
    shadowView.layer.shadowRadius = raduis
    shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    shadowView.layer.rasterizationScale = UIScreen.main.scale
    shadowView.layer.shouldRasterize = true
    superview?.insertSubview(shadowView, belowSubview: self)
  }
  
  
}
