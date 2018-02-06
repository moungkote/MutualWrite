//
//  BaseCollectionCell.swift
//  Mutualwrite
//
//  Created by MSlagger on 12/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
class TemplateCollectionCell: BaseCollectionCell, ReusableCell {
  
  static func inset() -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  static func size(_ bound: CGRect) -> CGSize {
    return CGSize(width: 100, height: 100)
  }
  
  static func spaceing() -> CGFloat {
    return 0
  }
  
  //MARK: Storage
  
  
  
  //MARK: Outlet
  
  
  
  //MARK: Action
  
  
  
}

// MARK: Life Cycle
extension TemplateCollectionCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForReuse()
  }
  
}


// MARK: Setup UI
extension TemplateCollectionCell {
  
  func setupView() {
    
    
  }
  
}

// MARK: Display Data
extension TemplateCollectionCell {
  
  func setupData() {
    
  }
  
}

class BaseCollectionCell: UICollectionViewCell {
  
  func setupShadow(radius: CGFloat = 6.0) {
    layer.shadowColor = AppColor.gray.cgColor
    layer.shadowOffset = CGSize(width:0, height: 0)
    layer.shadowRadius = radius
    layer.shadowOpacity = 1.0
    layer.masksToBounds = false
    layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                    cornerRadius: contentView.layer.cornerRadius).cgPath
  }
  
  func setupRaduis(radius: CGFloat = 6.0, width: CGFloat = 0.0) {
    contentView.layer.cornerRadius = radius
    contentView.layer.borderWidth = width
    contentView.layer.borderColor = AppColor.clear.cgColor
    contentView.layer.masksToBounds = true
  }
  
}

