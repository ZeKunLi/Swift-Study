
//
//  Student.swift
//  8.构造函数
//
//  Created by 李泽昆 on 17/3/15.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class Student: Person {
    var no:String
    //'重新'构造函数父类属性不能满足需求
    override init() {
        
        no = "10"
        super.init()
    }
    
    
    
}
