//
//  Test.swift
//  OCandSwift
//
//  Created by 李泽昆 on 17/3/24.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class Test: NSObject {
    
    // 实列方法
    func test() -> () {
        print("我是 Swift的实列方法")
    }
    // 类方法
     public class func testClass() -> () {
        print("我是 Swift的类方法")
    }
}
