//
//  PlotDiscoverTableViewCell.swift
//  Mutualwrite
//
//  Created by MSlagger on 23/12/2560 BE.
//  Copyright © 2560 Chitsanucha. All rights reserved.
//

import UIKit
import Alamofire

class PlotDiscoverTableViewCell: UITableViewCell {
  
  @IBOutlet weak var projectImageView: UIImageView!
  @IBOutlet weak var projectTitleLabel: UILabel!
  @IBOutlet weak var projectDescriptionLabel: UILabel!
  
  var cacheImage: UIImage?
  
  override func awakeFromNib() {
    super.awakeFromNib()
   
    projectImageView.layer.cornerRadius = 6
    
  }
  
}

extension PlotDiscoverTableViewCell {
  
  func setCell(project: Project) {
    projectTitleLabel.text = project.title
    if let imageString = project.imageURL {
      
      if let image = cacheImage {
        self.projectImageView.image = image
      }
      
      else {
        
        Alamofire.request(imageString).responseData(completionHandler: { (dataResponse) in
          
          switch dataResponse.result {
            
          case .success(let data):
            print("receieve data")
            let image = UIImage(data: data)
            self.projectImageView.image = image
            self.cacheImage = image
            break
          case .failure(let error):
            print("error \(error.localizedDescription)")
          }
        })
      }
    }
    projectDescriptionLabel.text = project.plotContent
  }
  
}
