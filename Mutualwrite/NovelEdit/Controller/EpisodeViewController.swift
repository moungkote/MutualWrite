//
//  EpisodeViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 26/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: ContainerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.layoutIfNeeded()
        delegate?.containerViewController(heigh: tableView.contentSize.height, for: self)
    }

}

extension EpisodeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "Content \(indexPath.row)"
        return cell!
    }
}
