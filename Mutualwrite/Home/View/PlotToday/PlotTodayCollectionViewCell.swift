//
//  PlotTodayCollectionViewCell.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

class PlotTodayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectDescriptionTextview: UITextView!
    
    
    func setCell(project: Project) {
        
        projectTitleLabel.text = project.title
        projectImageView.image = project.image as? UIImage
        projectDescriptionTextview.text = project.plotContent
    }
}
