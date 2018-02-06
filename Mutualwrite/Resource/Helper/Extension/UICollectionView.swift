//
//  UICollectionView.swift
//  TestSlim
//
//  Created by sasawat sankosik on 10/29/17.
//  Copyright © 2017 ssankosik. All rights reserved.
//

import UIKit
public extension UICollectionView {
  func registerCellClass(_ cellClass: AnyClass) {
    let identifier = String.className(cellClass)
    self.register(cellClass, forCellWithReuseIdentifier: identifier)
  }
  func registerCellNib(_ cellClass: AnyClass) {
    let identifier = String.className(cellClass)
    let nib = UINib(nibName: identifier, bundle: nil)
    self.register(nib, forCellWithReuseIdentifier: identifier)
  }
  func registerHeaderFooterViewClass(_ viewClass: AnyClass, kind: String) {
    let identifier = String.className(viewClass)
    self.register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
  }
  func registerHeaderFooterViewNib(_ viewClass: AnyClass, kind: String) {
    let identifier = String.className(viewClass)
    let nib = UINib(nibName: identifier, bundle: nil)
    self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
  }
}
