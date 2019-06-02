//
//  ViewController.swift
//  12.tableView
//
//  Created by 李泽昆 on 17/3/11.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        // 注册可重用单元格 OC [UITableviewCell Class]  switf UITableViewCell.self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        // default is nil 有值就使用
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

