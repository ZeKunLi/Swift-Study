//
//  ViewController.swift
//  2.Xcode8新特性
//
//  Created by 李泽昆 on 17/3/9.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - 视图生命周期
    // MARK: 视图生命周期
    // FIXME: 修改颜色
    // TODO: 设置颜色
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sss = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        sss.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 0.2235294118, alpha: 1)  // FIXME: 修改颜色
        
        
        
        view.addSubview(sss)  // TODO: 设置颜色
        
        
        
        let img = UIImageView(image: #imageLiteral(resourceName: "头像.jpg"))
        
        
        img.center = view.center
        
        view.addSubview(img)
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

