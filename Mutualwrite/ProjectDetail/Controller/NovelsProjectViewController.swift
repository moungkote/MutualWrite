//
//  NovelsProjectViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 20/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

class NovelsProjectViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var project: Project!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadNovels()
        self.setActionMenu()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ViewController init
    func viewController() -> NovelsProjectViewController {
        let storyboard = UIStoryboard(name: "NovelsProject", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "NovelsProjectViewControllerID") as! NovelsProjectViewController
    }
    
    func settingViewController(project: Project) {
        self.project = project
    }
    
    //require load view

    func loadNovels() {
        self.titleLabel.text = self.project.title
        self.contentTextView.text = self.project.plotContent
    }
    
    func setActionMenu() {
        let addCommentMenuItem = UIMenuItem(title: "Add Comment", action: #selector(addComment))
        UIMenuController.shared.menuItems = [addCommentMenuItem]
    }
    
    @objc func addComment() {
        if let range = self.contentTextView.selectedTextRange, let selectedText = contentTextView.text(in: range) {
            print("selectedText: \(selectedText)")
            print("start range: \(range.start)")
            print("end range: \(range.end)")
        }
        let vc = addCommentPopupViewController().viewController()
        self.present(vc, animated: true, completion: nil)
    }
}
