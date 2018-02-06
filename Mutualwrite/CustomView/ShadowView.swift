//
//  ShadowView.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

class ShadowView: UIView {
  
  var shadowLayer: CAShapeLayer!
  
  @IBInspectable var fillColor: UIColor = .white {
    didSet {
      shadowLayer.fillColor = fillColor.cgColor
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
  }
  
  @IBInspectable var shadowColor: UIColor = .clear {
    didSet {
      shadowLayer.shadowColor = shadowColor.cgColor
    }
  }
  
  @IBInspectable var shadowOpacity: Float = 0.0 {
    didSet {
      shadowLayer.shadowOpacity = shadowOpacity
    }
  }
  
  @IBInspectable var shadowRadius: CGFloat = 0.0 {
    didSet {
      shadowLayer.shadowRadius = shadowRadius
    }
  }
  
  @IBInspectable var shadowOffset: CGSize = CGSize.zero {
    didSet {
      shadowLayer.shadowOffset = shadowOffset
      
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    shadowLayer = CAShapeLayer()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.insertSublayer(shadowLayer, at: 0)
  }
  
}
