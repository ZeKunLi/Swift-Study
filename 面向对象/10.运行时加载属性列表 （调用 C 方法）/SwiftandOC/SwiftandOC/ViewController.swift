//
//  ViewController.swift
//  SwiftandOC
//
//  Created by 李泽昆 on 17/3/23.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 调用 OC 类方法
        Text.classText()
        
        // 调用 OC 实列方法
        let text = Text()
        text.text()
        
        
        
    }

    // 实列方法
    func test() -> () {
        print("我是 Swift的实列方法")
    }
    // 类方法
    public class func testClass() -> () {
        print("我是 Swift的类方法")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Text.test()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

