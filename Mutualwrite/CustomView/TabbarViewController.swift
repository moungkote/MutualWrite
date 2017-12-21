//
//  TabbarViewController.swift
//  Mutualwrite
//
//  Created by MSlagger on 20/12/2560 BE.
//  Copyright © 2560 Sritongsuk. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    private func setTabbar() {
        
        let nav = storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerID") as! UINavigationController
        let selectedImage = UIImage(named: "HomeActive")?.withRenderingMode(.alwaysOriginal)
        let image = UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        nav.tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        
        let nav2 = storyboard?.instantiateViewController(withIdentifier: "WriterViewControllerID") as! UINavigationController
        let selectedImage2 = UIImage(named: "WriterActive")?.withRenderingMode(.alwaysOriginal)
        let image2 = UIImage(named: "Writer")?.withRenderingMode(.alwaysOriginal)
        nav2.tabBarItem = UITabBarItem(title: nil, image: image2, selectedImage: selectedImage2)
        
        let nav3 = storyboard?.instantiateViewController(withIdentifier: "ProjectMasterViewController")as! UINavigationController
        nav3.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        let selectedImage3 = UIImage(named: "Create")?.withRenderingMode(.alwaysOriginal)
        let image3 = UIImage(named: "Create")?.withRenderingMode(.alwaysOriginal)
        nav2.tabBarItem = UITabBarItem(title: nil, image: image3, selectedImage: selectedImage3)
        
        
        let nav4 = storyboard?.instantiateViewController(withIdentifier: "TeamViewControllerID") as! UINavigationController
        let selectedImage4 = UIImage(named: "teamActive")?.withRenderingMode(.alwaysOriginal)
        let image4 = UIImage(named: "team")?.withRenderingMode(.alwaysOriginal)
        nav4.tabBarItem = UITabBarItem(title: nil, image: image4, selectedImage: selectedImage4)
        
        let nav5 = storyboard?.instantiateViewController(withIdentifier: "ProfileViewControllerID")as! UINavigationController
        let selectedImage5 = UIImage(named: "profileActive")?.withRenderingMode(.alwaysOriginal)
        let image5 = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        nav5.tabBarItem = UITabBarItem(title: nil, image: image5, selectedImage: selectedImage5)
        
        self.viewControllers = [nav,nav2, nav3, nav4, nav5]
    }
    
    private func setMiddleTabbar() {
        
        let x = view.bounds.width/2 - 25.5
        let y = view.bounds.height - 49
        let frame = CGRect(x: x, y: y, width: 49, height: 49)
        let button = UIButton(frame: frame)
        button.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
        let image = UIImage(named: "Create")
        button.setImage(image, for: .normal)
        button.setTitle(nil, for: .normal)
        view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton) {
        
        selectedIndex = 2
    }


}
