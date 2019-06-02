//
//  ViewController.swift
//  7.加法计算机
//
//  Created by 李泽昆 on 17/3/15.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tfNumber1:UITextField?
    var tfNumber2:UITextField?
    var conuntLab:UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() -> () {
        let t1 = UITextField(frame: CGRect(x: 20, y: 20, width: 100, height: 30))
        t1.borderStyle = .roundedRect
        t1.text = "0"
        view.addSubview(t1)
        tfNumber1 = t1
        let t2 = UITextField(frame: CGRect(x: 170, y: 20, width: 100, height: 30))
        t2.borderStyle = .roundedRect
        t2.text = "0"
        view.addSubview(t2)
        tfNumber2 = t2
        let l1 = UILabel(frame: CGRect(x: 120, y: 20, width: 30, height: 30))
        l1.textAlignment = .center
        l1.text = "+"
        view.addSubview(l1)
        
        let l2 = UILabel(frame: CGRect(x: 270, y: 20, width: 30, height: 30))
        l2.textAlignment = .center
        l2.text = "="
        view.addSubview(l2)
        
        let l3 = UILabel(frame: CGRect(x: 300, y: 20, width: 50, height: 30))
        l3.textAlignment = .center
        l3.text = ""
        view.addSubview(l3)
        conuntLab = l3
        
        
        let button = UIButton(type: .roundedRect)
        
        button.sizeToFit()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.center = view.center
        button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        button.setTitle("计算", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(calc), for: .touchUpInside)
        view.addSubview(button)
        
   
        
    }
    
    func calc() -> () {
        print("\(tfNumber1?.text) + \(tfNumber2?.text)")
        // int文本框内容如果不是数字就为 nil
        // 可选项两种写法
        // 1.强行拆包 如果有值就是值没值就是空 Int((tfNumber?.text)!)
        // 2.三目运算 (tfNumber2?.text ?? "")
        guard let number1 = Int((tfNumber1?.text)!),
        let number2 = Int(tfNumber2?.text ?? "0")
        
            else {
            print("值为空")
            return
        }
        
        // 处理结果
        conuntLab?.text = "\(number1+number2)"
        
        
    }


}

