//
//  ViewController.swift
//  4.GCD
//
//  Created by 李泽昆 on 17/3/15.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 闭包执行场景
        // 1.异步执行回调
        // 2.控制器回调
        // 3.自定义视图回调
        
        
        
    
    }

    func loadData(completion: (result: [String]) ->()) -> () {
        // 将任务添加到队列，指定执行任务的函数。
        // 队列调度任务(block,闭包），以异步或同步的方式执行任务。
        // 异步执行任务，获取结果,通过 block 和闭包进行回调
        // Swift 的闭包和OC 的block 完全一样
        DispatchQueue.global().async { 
            print("耗时操作\(Thread.current)")
            Thread.sleep(forTimeInterval: 2)
            let json = ["头条","出大事了","八卦"]
            DispatchQueue.main.async(execute: { 
                
                print("刷新 UI\(Thread.current)")
                
            })
            
            
            
            
        }
    }


}

