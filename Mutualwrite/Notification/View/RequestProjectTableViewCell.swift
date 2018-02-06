//
//  RequestProjectTableViewCell.swift
//  Mutualwrite
//
//  Created by MSlagger on 21/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol RequestProjectTableViewCellDelegate: class {
  
  func requestProject(didAccept request: Request)
  func requestProject(didDecline request: Request)
}

class RequestProjectTableViewCell: UITableViewCell {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var requestLabel: UILabel!
  
  weak var delegate: RequestProjectTableViewCellDelegate?
  private var request: Request!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setCell(request: Request) {
    self.request = request
    if let url = URL.init(string: request.profileURL) {
      profileImageView.af_setImage(withURL: url)
    }
    requestLabel.text = "\(request.userName) want to join \(request.projectName)"
    
  }
  
  @IBAction func acceptRequest(_ sender: UIButton) {
    delegate?.requestProject(didAccept: self.request)
  }

  @IBAction func declineRequest(_ sender: UIButton) {
    
    delegate?.requestProject(didDecline: self.request)
    
  }
}

