//
//  ProjectInfoViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 21/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit

class ProjectInfoViewController: UIViewController {

  @IBOutlet weak var plotContentLabel: UILabel!
  
  var project: Project!
  var isExpanded = false
  
    override func viewDidLoad() {
        super.viewDidLoad()

        plotContentLabel.text = project.plotContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func toggleCollapse(_ sender: UIButton) {
    
    if isExpanded {
      plotContentLabel.numberOfLines = 5
    }else {
      plotContentLabel.numberOfLines = 0
    }
    
    isExpanded = !isExpanded
  }
  

}
