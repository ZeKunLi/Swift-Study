//
//  ViewController.swift
//  12.泛型
//
//  Created by ZeKunLi on 2019/6/9.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        


        show(name: "LiZeKun")
        show(age: 18)
        show(height: 188.88)
        show(para: 88.88)
        testForShow(name: 123, object: 123)
        
    }
    
    func show<T>(para:T) {
        print("Hello \(para)")
    }
 
    func show(name:String) {
        print("Hello \(name)")
    }
    
    func show(age:Int) {
        print("Hello \(age)")
    }
    
    func show(height:Double) {
        print("Hello \(height)")
    }
    
    func testForShow<T ,U>(name : T,object : U){
        print("Hello \(name)" + "\(object)")
    }
    


}

