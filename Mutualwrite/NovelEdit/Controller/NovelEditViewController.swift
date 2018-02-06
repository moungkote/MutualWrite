//
//  NovelEditViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 25/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
import MXParallaxHeader
import FirebaseDatabase

protocol ContainerViewControllerDelegate: class {
    func containerViewController(heigh: CGFloat,for viewController: UIViewController)
}

class NovelEditViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerViewHeigh: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var projectCoverImageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    
    var plot: Plot?
    
    lazy var plotViewController: PlotViewController = {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PlotViewController") as! PlotViewController
        self.addChildViewController(viewController)
        viewController.delegate = self
        return viewController
    }()
    
    lazy var episodeViewController: EpisodeViewController = {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "EpisodeViewController") as! EpisodeViewController
        self.addChildViewController(viewController)
        viewController.delegate = self
        return viewController
    }()
    
    lazy var plotRef = Database.database().reference().child("Plots")
    var currentViewController: UIViewController?
    var project: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupParallaxHeader()
        selectViewController(at: 0)
        fetchPlot()
        if let url = URL.init(string: project.imageURL ?? ""){
            self.coverImageView.af_setImage(withURL: url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? WritePlotViewController {
            vc.plotItem = sender as? PlotItem
            vc.projectId = self.project.id
        }
        
        if let vc = segue.destination as? NovelsProjectViewController {
            let object = sender as! (PlotItem?, PlotType)
            vc.plotItem = object.0
            vc.project = self.project
            vc.plotType = object.1
            
        }
    }
    
    private func setupParallaxHeader() {
        
        scrollView.parallaxHeader.view = headerView
        scrollView.parallaxHeader.height = 245
        scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill
        scrollView.parallaxHeader.minimumHeight = 100
        
    }
    
    private func setPlot() {
        self.plotViewController.setPlot(plot: self.plot!)
    }
    
    private func selectViewController(at index: Int) {
        
        if index == 0 {
            currentViewController = self.plotViewController
            self.episodeViewController.view.removeFromSuperview()
            self.containerView.layoutIfNeeded()
            self.containerView.addSubview(self.plotViewController.view)
            self.self.plotViewController.view.frame = self.containerView.bounds
        }else {
            currentViewController = self.episodeViewController
            self.plotViewController.view.removeFromSuperview()
            self.containerView.layoutIfNeeded()
            self.containerView.addSubview(self.episodeViewController.view)
            self.self.episodeViewController.view.frame = self.containerView.bounds
        }
    }
    
    private func fetchPlot() {

        plotRef.child(project.id!).observe(.value) { (snap) in
            self.plot = Plot(snap: snap)
            self.setPlot()
        }
    }
    
    @IBAction func selectViewController(_ sender: UISegmentedControl) {
        self.selectViewController(at: sender.selectedSegmentIndex)
    }
}

extension NovelEditViewController: ContainerViewControllerDelegate {
    
    func containerViewController(heigh: CGFloat, for viewController: UIViewController) {
        
        print(type(of: viewController))
        
        if viewController == currentViewController {
            print("set heigh : \(heigh), for :\(type(of: viewController))")
            self.containerViewHeigh.constant = heigh
        }
        
    }
    
    
}

