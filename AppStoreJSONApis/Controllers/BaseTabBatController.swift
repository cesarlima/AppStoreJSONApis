//
//  BaseTabBatController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 02/08/19.
//  Copyright © 2019 br.com.cesarlima. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            creatNavController(viewController: AppsController(), title: "Apps", imageName: "apps"),
            creatNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
            creatNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon"),
        ]
    }
    
    fileprivate func creatNavController(viewController:UIViewController, title:String, imageName:String) -> UIViewController {
        
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        
        let navControler = UINavigationController(rootViewController: viewController)
        navControler.tabBarItem.title = title
        navControler.tabBarItem.image = UIImage(named: imageName)
        navControler.navigationBar.prefersLargeTitles = true
        
        return navControler
    }
}
