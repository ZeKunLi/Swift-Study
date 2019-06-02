//
//  ViewController.swift
//  11.字典
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        demo4()
    }
    // MARK:定义
    func demo1()  {
        let dic = ["key":"value","k":"v"]
        print(dic)
        
        
        let arr = [
            ["key":"value","k":"v"],
            ["key":"value","k":"v"]
        ]
        
        
        print(arr)
        
    }
    // MARK:遍历
    func demo2()  {
        let dic = ["哈希":"hasa","sd":"dd"]
        // 元祖   let d: (key: String, value: String)
        for d in dic {
            print("\(d.value) \(d.key)")
            
            // 前面是 KEY 能够单独取值 元祖
            //
            
        }
    }
    // MARK:增删改
    func demo3()  {
        
        var dic = ["哈希":"hasa","sd":"dd"]
        // 添加  如果 KEY 不存在就增加
        dic["李泽昆"] = "男神"
        // 修改  如果 KEY 存在就修改
        dic["李泽昆"] = "帅哥"
        // 删除 如果有 KEY 就删除
        // key 是根据 KEY 值来定位的, key 值必须是可以哈希的 hash 'MD5'的一种
        // hash 就是将字符串变成唯一的整数,便于超找,提高字典遍历速度。
        dic.removeValue(forKey: "李泽昆")
        print(dic)
        
    }
    // MARK:合并
    func demo4()  {
        var dic = ["哈希":"hasa","sd":"dd"]
        let dic2 = ["哈":"hasa","s":"dd"]
        
        // 字典不能直接相加
//        dic += dic2
        // 如果 以此遍历添加
        // 如果key 有值 添加 ， 如果 key 没值设置
        
        for e in dic2 {
            
            // 设置 key            // 取值
            dic[e.key] = dic2[e.key]
        }
        
        print(dic)
        
        
    }
    


}

