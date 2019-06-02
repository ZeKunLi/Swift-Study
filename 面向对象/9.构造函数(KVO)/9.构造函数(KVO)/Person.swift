
//
//  Person.swift
//  9.构造函数(KVO)
//
//  Created by 李泽昆 on 17/3/17.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
/**
    1.定义模型的时候对象通常都是可选的.
    -在需要的时候创建。
    -避免写构造函数,可以简化代码
    2.定义基本数据类型不能使用可选值,而且要设置值，否则 KVC会崩溃!
    3.如果需要使用KVC设置,属性不能是private
    4.使用 KVC 方法必须保证对象实列化完成。所以要调用 super.init 保证对象初始化完成!!
 
 */

class Person: NSObject {
    
    //name属性时可选的，在 OC 中的很多属性都是在需要的是候创建的。
    //应为手机开发内存很宝贵,有些对象的属性并不需要分配空间。
    //延迟加载，在需要的时候创建
    var name:String?
    //给基本数据类型初始化
    //-使用 KVC会提示无法找到 Key
    //-原因:int 是一个基本数据类型的结构体，OC中没有,OC中只有基本数据类型
    var age:Int = 0
//    var title:String?  //private
    
    
    
    // 重载构造函数用字典为本类属性设置初始值
    init(dict:[String:Any]) {
        
        super.init()
        // 使用setValuesForKeys 方法**之前**应该调用 super.init
        // Use of 'self' in method call 'setValuesForKeys' before super.init initializes self
        // KVC的方法是 OC 的方法,**KVC是在运行时给对象发送消息
        // 发送消息给对象必须要求对象实列化完成!
        setValuesForKeys(dict)
        
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("ss")
    }
    
    
}
