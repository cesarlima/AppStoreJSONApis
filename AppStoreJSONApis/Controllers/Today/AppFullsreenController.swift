//
//  AppFullsreenController.swift
//  AppStoreJSONApis
//
//  Created by MacPro on 07/05/21.
//  Copyright © 2021 br.com.cesarlima. All rights reserved.
//

import UIKit

class AppFullsreenController: UITableViewController {
    var dismissHandler: (() -> Void)?
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = AppFullscreenHeaderCell()
            cell.dismissHandler = self.dismissHandler
            cell.todayCell.todayItem = todayItem
            return cell
        }
        
        let cell = AppFullscreenDescriptionCell(style: .default, reuseIdentifier: nil)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 494
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = TodayCell()
//        return view
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 330
//    }
}
