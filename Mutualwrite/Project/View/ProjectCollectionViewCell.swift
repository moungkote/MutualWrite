//
//  ProjectCollectionViewCell.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    func setCell(project: Project) {
        
        projectNameLabel.text = project.title
        projectImageView.image = project.image as? UIImage
    }
}
