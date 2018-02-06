//
//  PlotTodayCollectionViewCell.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

class PlotTodayCollectionViewCell: BaseCollectionCell {
  
  @IBOutlet weak var projectTitleLabel: UILabel!
  @IBOutlet weak var projectImageView: UIImageView!
  @IBOutlet weak var projectDescriptionTextview: UITextView!
  
    @IBOutlet weak var userLimitLabel: UILabel!
    @IBOutlet weak var view_container: UIView!
    @IBOutlet weak var authorAdminLabel: UILabel!
    
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
}

extension PlotTodayCollectionViewCell {
  
  func setCell(project: Project) {
    projectTitleLabel.text = project.title
    if let imageString = project.imageURL {
      if let imageURL = URL(string: imageString) {
        self.projectImageView.af_setImage(withURL: imageURL)
      }
    } else {
      self.projectImageView.image = nil
    }
    projectDescriptionTextview.text = project.plotContent
    //userLimitLabel.text = project.memberLimit
    //authorAdminLabel.text = project.projectOwnerUserId
    
  }
  
  func setupView() {
    view_container.cornerRaduis(raduis: 6)
    projectImageView.clipsToBounds = true
  }
  
  func setupRaduis() {
    setupRaduis(radius: 6)
  }
  
  func setupShadow() {
    setupShadow(radius: 10)
  }
  
}
