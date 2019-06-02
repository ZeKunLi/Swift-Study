//
//  ViewController.swift
//  1.Switf第一个代码
//
//  Created by 李泽昆 on 17/3/9.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
/*
 1.  类名（）== allac init
 2.  ()代表执行
 3.  不使用 self. 
    原因：闭包类似于 OC 的 Block) 需要使用 self.
    建议：平时也可以使用 建议不使用 在编译器提示的时候再使用,会对‘语境’有更好的体验。
 4.   没有;  分割语句 默认不需要
 5.  枚举值类型
    OC UIbuttonTypeadd
    swift .add
 6. 监听方法 
    OC @selector
    swift #selector
 7. 输出
    OC NSLog 
    swift print
 
 **/
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100));
        
        view .addSubview(subView)
        
        
        let button = UIButton(type: UIButtonType.contactAdd)
        button.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
        subView .addSubview(button);
        
        
        
        
    }
    
    // Argument of '#selector' refers to instance method 'buttonClick(sender:)' that is not exposed to Objective-C
    // Add '@objc' to expose this instance method to Objective-C
    // 方法暴露给 OC 类必须在方法前声明@objc
    @objc func buttonClick(sender: UIButton) -> Void {
        print(sender)
        print("Hello Swift4")
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

