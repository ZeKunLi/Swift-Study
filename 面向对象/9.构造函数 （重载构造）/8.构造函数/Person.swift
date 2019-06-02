//
//  Person.swift
//  8.构造函数
//
//  Created by 李泽昆 on 17/3/15.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
/**
 1.构造函数的目的:给自己的属性分配空间并且设置初始值
 2.调用父类构造函数之前,需要先给本类属性设置初始值
 3.调用父类的'构造函数'的目的给父类的属性分配空间设置初始者
 4.如果重载构造函数,并没有实现父类的 init()的方法,系统不再提供 Init 构造函数默认会有的！！！！
  - 应为默认的构造函数并不能给本类的属性分配空间!
 NSObject没有属性,只有一个成员变量 'isa'
 */
class Person: NSObject {
        var name:String
    
    
//     override init() {
//
//        name = "Chainsmokers"
//        super.init()
//
//    }
    //'重载',函数名相同，但是参数个数不同。
    // -重载可以给自己的属性从外部设置初始值。
    // OC 中没有重载！！！！ （initWithXXXXX  ）
    init(name:String) {
        // 使用参数给属性设置初始值
         self.name = name
        
        
    }

    //  Property 'self.name' not initialized at implicitly generated super.init call
    //  在隐世调用 super.init 之前属性 self.name 没有初始化
    

}
