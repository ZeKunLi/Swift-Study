//
//  ViewController.swift
//  8.for 循环
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        demo()
        
        let l = 0...5
        let l1 = 0..<5
            
        print(l)
        print(l1)
        
        
        // MARK:reversed() 翻转
        for var i in (0...5).reversed() {
            print(i)
        }
        
    }

    func demo () {
        for var i in 0..<5 {
            
            print(i)
        }
   
        
            print("-----")
        
        for var i in 0...5 {
            print(i)
        }
    }

}

