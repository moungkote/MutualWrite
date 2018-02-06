//
//  CreateProjectViewController.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import HexColors

class ProjectMasterViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: SPSegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    lazy var projectViewController: ProjectViewController = {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProjectViewController") as! ProjectViewController
        addChildViewController(vc)
        vc.view.frame = containerView.bounds
        self.containerView.addSubview(vc.view)
        return vc
    }()
    
    lazy var ideaViewController: IdeaViewController = {
        let vc = storyboard?.instantiateViewController(withIdentifier: "IdeaViewController") as! IdeaViewController
        addChildViewController(vc)
        vc.view.frame = containerView.bounds
        self.containerView.addSubview(vc.view)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.layer.borderColor = AppColor.dark_yellow.cgColor
        segmentControl.backgroundColor = AppColor.dark_yellow.color
        segmentControl.indicatorView.backgroundColor = AppColor.light_yellow.color
        segmentControl.styleDelegate = self
        
        
        //first segment control
        
        let xFirstCell = self.createCell(
            text: "Project",
            image: nil
        )
        let xSecondCell = self.createCell(
            text: "Idea",
            image: nil
        )
        
        for cell in [xFirstCell, xSecondCell] {
            cell.layout = .textWithImage
            self.segmentControl.add(cell: cell)
        }
        
        selectSegment(at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = AppColor.yellow.color
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NovelEditViewController {
            vc.project = sender as? Project
        }
    }
    
    private func createCell(text: String, image: UIImage?) -> SPSegmentedControlCell {
        let cell = SPSegmentedControlCell.init()
        cell.label.text = text
        cell.label.font = UIFont(name: "Avenir-Medium", size: 13.0)!
        cell.imageView.image = image
        return cell
    }
    
    private func selectSegment(at index: Int) {
        
        projectViewController.view.isHidden = index == 0 ? false : true
        ideaViewController.view.isHidden = index == 1 ? false : true
    }
    
}

// MARK: - SegmentControl

extension ProjectMasterViewController: SPSegmentControlCellStyleDelegate {
    
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

