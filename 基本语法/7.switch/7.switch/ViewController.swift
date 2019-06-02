//
//  ViewController.swift
//  7.switch
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        demo(i: "10")
        demo2()
        
        
    }

    func demo(i:String)  {
        /*
         1.switch 可以对任意类型进行分支，不只局限于 switch
         2.switch 一般使用 break
         3.需要穿透的时候用,将值分隔开
         4.每个分支只需要执行一条语句,什么都不敢才使用 break
 
 
        **/
        
        switch i {
        case "10","20":
            print("优")
        default:
            print("一般")
        }
    }
    
    
    func demo2() {
        let point = CGPoint(x: 0, y: 10)
        switch point {
        case let p where p.x == 0 && p.y == 0:
            print("原点")
        case let p where p.x == 0:
            print("Y轴")
        case let p where p.y == 0:
            print("X轴")
        case let p where abs(p.x) == abs(p.y):
            print("对角线")
        default:
            print("其他")
        }
        
    }


}

