//
//  ProjectDetailsViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 21/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
import AlamofireImage
import TTGTagCollectionView
import FirebaseDatabase

class ProjectDetailsViewController: UIViewController {

  @IBOutlet weak var projectCoverImageView: UIImageView!
  @IBOutlet weak var categoriesView: TTGTextTagCollectionView!
  @IBOutlet weak var projectNameLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var projectOwnerLabel: UILabel!
  @IBOutlet weak var projectImageView: UIImageView!
  @IBOutlet weak var segmentControl: SPSegmentedControl!
  
  var project: Project!
  lazy var projectWritersViewController: ProjectWritersViewController = {
    let vc = storyboard?.instantiateViewController(withIdentifier: "ProjectWritersViewController") as! ProjectWritersViewController
    addChildViewController(vc)
    vc.view.frame = containerView.bounds
    self.containerView.addSubview(vc.view)
    return vc
  }()
  
  lazy var projectInfoViewController: ProjectInfoViewController = {
    let vc = storyboard?.instantiateViewController(withIdentifier: "ProjectInfoViewController") as! ProjectInfoViewController
    vc.project = self.project
    addChildViewController(vc)
    vc.view.frame = containerView.bounds
    self.containerView.addSubview(vc.view)
    return vc
  }()
  
  override func viewDidLoad() {
        super.viewDidLoad()

    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.backgroundColor = .clear
    navigationController?.navigationBar.shadowImage = UIImage()
    segmentControl.layer.borderColor = AppColor.dark_yellow.cgColor
    segmentControl.backgroundColor = AppColor.dark_yellow.color
    segmentControl.indicatorView.backgroundColor = AppColor.light_yellow.color
    segmentControl.styleDelegate = self
    
    
    //first segment control
    
    let xFirstCell = self.createCell(
      text: "Project Infomation",
      image: nil
    )
    let xSecondCell = self.createCell(
      text: "Writers",
      image: nil
    )
    
    for cell in [xFirstCell, xSecondCell] {
      cell.layout = .textWithImage
      self.segmentControl.add(cell: cell)
    }
    
    selectSegment(at: 0)
    setProject()
  }
  
  private func setProject() {
    
    categoriesView.addTag("Drama")
    projectNameLabel.text = project.title
    projectCoverImageView.af_setImage(withURL: URL.init(string: project.imageURL!)!)
    projectImageView.af_setImage(withURL: URL.init(string: project.imageURL!)!)
    projectOwnerLabel.text = project.projectOwnerUserId
    
    
  }

  private func createCell(text: String, image: UIImage?) -> SPSegmentedControlCell {
    let cell = SPSegmentedControlCell.init()
    cell.label.text = text
    cell.label.font = UIFont(name: "Avenir-Medium", size: 13.0)!
    cell.imageView.image = image
    return cell
  }
  
  private func selectSegment(at index: Int) {
    
    projectInfoViewController.view.isHidden = index == 0 ? false : true
    projectWritersViewController.view.isHidden = index == 1 ? false : true
  }
  
  @IBAction func back(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func joinProject(_ sender: UIButton) {
    
    let requestRef = Database.database().reference().child("Requests")
    let requestId = requestRef.childByAutoId().key
    let user = UserData.shared
    var value = [String: Any]()
    value["requestId"] = requestId
    value["userId"] = user?.userId
    value["userName"] = user?.userName
    value["profileURL"] = user?.profileURL
    value["projectId"] = project.id
    value["projectName"] = project.title
    value["projectOwnerUserId"] = project.userId
    requestRef.child(requestId).setValue(value)
    
  }
}

// MARK: - SegmentControl

extension ProjectDetailsViewController: SPSegmentControlCellStyleDelegate {
  
  func selectedState(segmentControlCell: SPSegmentedControlCell, forIndex index: Int) {
    
    selectSegment(at: index)
    
    UIView.transition(with: segmentControlCell.label, duration: 0.1, options: [.transitionCrossDissolve, .beginFromCurrentState], animations: {
      
      segmentControlCell.label.textColor = UIColor.white
    }, completion: nil)
  }
  
  func normalState(segmentControlCell: SPSegmentedControlCell, forIndex index: Int) {
    
    UIView.transition(with: segmentControlCell.label, duration: 0.1, options: [.transitionCrossDissolve, .beginFromCurrentState], animations: {
      
      segmentControlCell.label.textColor = UIColor("ffcc48")
    }, completion: nil)
  }
}
