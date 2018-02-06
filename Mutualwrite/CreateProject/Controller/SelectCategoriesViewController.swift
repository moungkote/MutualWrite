//
//  SelectCatergoriesViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 19/1/2561 BE.
//  Copyright © 2561 Chitsanucha. All rights reserved.
//

import UIKit
import  FirebaseDatabase

protocol SelectCategoriesViewControllerDelegate:class {
  func didSelectCategory(category:Category)
}

class SelectCategoriesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  lazy var cateRef = Database.database().reference().child("Categories")
  var categories = [Category]()
  weak var delegate:SelectCategoriesViewControllerDelegate?
  
  override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchCategories()
    }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first{
      if touch.view == self.view{
        self.dismiss(animated: true, completion: nil)
      }
    }
  }

  private func fetchCategories(){
    cateRef.observe(.value) { (snapshot) in
      //print(snapshot.value)
      
      let dataSnapshotArray = snapshot.children.allObjects as! [DataSnapshot]
      self.categories = dataSnapshotArray.flatMap({ Category.init(snap: $0) })
      self.tableView.reloadData()
    }
  }

}

extension SelectCategoriesViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categories.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
    cell.textLabel?.text = categories[indexPath.row].name
    return cell
    
  }
}

extension SelectCategoriesViewController:UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let category = categories[indexPath.row]
    delegate?.didSelectCategory(category: category)
    self.dismiss(animated: true, completion: nil)
  }
}
