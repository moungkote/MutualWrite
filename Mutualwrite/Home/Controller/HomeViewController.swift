//
//  HomeViewController.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    
    private lazy var novelsRef: DatabaseReference = Database.database().reference().child("Novels")
    private var novlesRefHandle: DatabaseHandle?
    
    deinit {
        if let refHandle = novlesRefHandle {
            novelsRef.removeObserver(withHandle: refHandle)
        }
    }
    
    var projectArray = [Project]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProject()
    }

    private func fetchProject() {
        
//        let req: NSFetchRequest<Project> = Project.fetchRequest()
//        if let result = try? context.fetch(req) {
//            projectArray = result
//        }
        self.novlesRefHandle = novelsRef.queryOrderedByKey().observe(.value) { (data) in
            
            let dataSnapshotArray = data.children.allObjects as! [DataSnapshot]
            
            self.projectArray = dataSnapshotArray.map({ (data) -> Project in
                
                let projectData = data.value as! [String: String]
                
                let project = Project.getProjectArray(withDataSnapshot: projectData)
                return project
            })
        }
    }
    
}


// MARK: - UITableViewDataSource

extension HomeViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}

// MARK: - UICollection

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return projectArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlotTodayCollectionViewCell", for: indexPath) as! PlotTodayCollectionViewCell
        cell.setCell(project: projectArray[indexPath.item])
        return cell
    }
    
}
extension HomeViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let vc = NovelsProjectViewController().viewController()
        vc.settingViewController(project: self.projectArray[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
