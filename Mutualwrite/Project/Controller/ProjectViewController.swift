//
//  ProjectViewController.swift
//  Mutualwrite
//
//  Created by MAC on 16/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProjectViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
      
      guard let user = UserData.shared else { return }
      
      novelsRef.queryOrdered(byChild: "members/\(user.userId)/userId").queryEqual(toValue: user.userId).observe(.value) { (data) in
        
        let dataSnapshotArray = data.children.allObjects as! [DataSnapshot]
        
        self.projectArray = dataSnapshotArray.map({ (data) -> Project in
          
          return Project.init(withDataSnapshot: data)
          
        })
        
      }
    
    }

}

// MARK: - UICollectionView

extension ProjectViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "createProjectCell", for: indexPath)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCollectionViewCell", for: indexPath) as! ProjectCollectionViewCell
            cell.setCell(project: projectArray[indexPath.item - 1])
            return cell
        }
        
    }
}

extension ProjectViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    parent?.performSegue(withIdentifier: "novelEdit", sender: self.projectArray[indexPath.item - 1])
  }
}

extension ProjectViewController: UICollectionViewDelegateFlowLayout {
    
}
