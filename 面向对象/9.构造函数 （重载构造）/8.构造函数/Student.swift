//
//  Student.swift
//  8.构造函数
//
//  Created by 李泽昆 on 17/3/17.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class Student: Person {
    var no:String
    
    init(no:String,name:String) {
        self.no = no
        super.init(name: name)
    }
    
}
