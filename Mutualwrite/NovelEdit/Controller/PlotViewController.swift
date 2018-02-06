//
//  PlotViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 26/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit

class PlotViewController: UIViewController {

    @IBOutlet weak var beginningContentLabel: UILabel!
    @IBOutlet weak var beginningLastEditLabel: UILabel!
    @IBOutlet weak var beginningUserImageView: UIImageView!
    
    @IBOutlet weak var middlePlotContentLabel: UILabel!
    @IBOutlet weak var middleLastEditLabel: UILabel!
    @IBOutlet weak var middleUserImageView: UIImageView!
    
    @IBOutlet weak var endingPlotContentLabel: UILabel!
    @IBOutlet weak var endingLastEditLabel: UILabel!
    @IBOutlet weak var endingUserImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    weak var delegate: ContainerViewControllerDelegate?
    var plot: Plot!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.layoutIfNeeded()
        delegate?.containerViewController(heigh: scrollView.contentSize.height, for: self)
    }
    
    func setPlot(plot: Plot) {
        self.plot = plot
        beginningContentLabel.text = plot.plotbeginning?.content
        beginningLastEditLabel.text = plot.plotbeginning?.lastUpdate
        fetchUserImage(by: plot.plotbeginning?.editByUserImageURL, imageView: beginningUserImageView)
        
        middlePlotContentLabel.text = plot.plotMiddle?.content
        middleLastEditLabel.text = plot.plotMiddle?.lastUpdate
        fetchUserImage(by: plot.plotMiddle?.editByUserImageURL, imageView: middleUserImageView)
        
        endingPlotContentLabel.text = plot.plotEnding?.content
        endingLastEditLabel.text = plot.plotEnding?.lastUpdate
        fetchUserImage(by: plot.plotEnding?.editByUserImageURL, imageView: endingUserImageView)
    }

    private func fetchUserImage(by userImageURL: String?, imageView: UIImageView) {
        
        guard userImageURL != nil else { return }
        if let url = URL.init(string: userImageURL!){
            imageView.af_setImage(withURL: url)
        }
    }
 
    @IBAction func witeBeginningPlot(_ sender: UIButton) {
        let object = (self.plot.plotbeginning, PlotType.beginning) as (PlotItem?, PlotType)
        parent?.performSegue(withIdentifier: "writePlot", sender: object)
    }
    @IBAction func writeMiddlePlot(_ sender: Any) {
        let object = (self.plot.plotMiddle, PlotType.middle) as (PlotItem?, PlotType)
        parent?.performSegue(withIdentifier: "writePlot", sender: object)
    }
    @IBAction func writeEnddingPlot(_ sender: Any) {
        let object = (self.plot.plotEnding, PlotType.ending) as (PlotItem?, PlotType)
        parent?.performSegue(withIdentifier: "writePlot", sender: object)
    }
    
    
}
