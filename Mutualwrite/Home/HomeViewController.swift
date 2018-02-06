//
//  ViewController.swift
//  TableView
//
//  Created by MSlagger on 13/1/2561 BE.
//  Copyright © 2561 MSlagger. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {

  // MARK - Firebase
  private lazy var ref_novels: DatabaseReference = Database.database().reference().child("Novels")
  private var novlesRefHandle: DatabaseHandle?
  
  
  // MARK - UI
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var headerView: UIView!
  
  
  // MARK - Storage
  var data_plotToday = [Project]()
  var data_discover = [Project]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchPlotToday()
    fetchDiscover()
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let vc = segue.destination as? ProjectDetailsViewController {
      vc.project = sender as? Project
    }
  }
  
  
  // MARK: - FIRE Database

  private func fetchPlotToday() {
    self.novlesRefHandle = ref_novels.queryOrderedByKey().queryLimited(toFirst: 10).observe(.value) { (data) in
      let dataSnapshotArray = data.children.allObjects as! [DataSnapshot]
      self.data_plotToday = dataSnapshotArray.flatMap({ Project(withDataSnapshot: $0) })
      self.collectionView.reloadData()

    }
  }
  
  private func fetchDiscover() {
    ref_novels.queryOrderedByKey().observe(.value, with: { snapshot in
      let data = snapshot.children.allObjects as! [DataSnapshot]
      self.data_discover = data.flatMap({ Project(withDataSnapshot: $0) })
      self.tableView.reloadData()
    })
  }

}


extension HomeViewController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data_discover.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "PlotDiscoverTableViewCell") as! PlotDiscoverTableViewCell
    cell.setCell(project: data_discover[indexPath.item])
    return cell
  }
}

extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    return headerView
  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = data_plotToday[indexPath.item]
        performSegue(withIdentifier: "projectDetails", sender: project)
    }
}


// MARK: - UICollection
extension HomeViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    return 10
    return data_plotToday.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlotTodayCollectionViewCell", for: indexPath) as! PlotTodayCollectionViewCell
    cell.setCell(project: data_plotToday[indexPath.item])
    cell.setupRaduis()
    cell.setupShadow()
    return cell
  }
  
}

extension HomeViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
//    let vc = NovelsProjectViewController().viewController()
//    vc.settingViewController(project: data_plotToday[indexPath.row])
//    self.navigationController?.pushViewController(vc, animated: true)
    
    let project = data_plotToday[indexPath.item]
    performSegue(withIdentifier: "projectDetails", sender: project)
  }
  
}

