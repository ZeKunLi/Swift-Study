//
//  ViewController.swift
//  9.字符串
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // String 是一个结构体，性能更高,String 支持遍历
        
        
        
        let name = ["","",""]
        
        
        insertString()

    }
    
    func forinString() {
        for character in "Dog!🐶" {
            print(character)
        }
    }
    
    func initString() {
        var emptyString = ""              // 空字符串变量
        var anotherEmptyString = String() // 初始化方法
        let precomposed: Character = "\u{D55C}" // 한
        let decomposed: Character = "\u{1112}\u{1161}" // ᄒ, ᅡ, ᆫ
        print(precomposed)
        print(decomposed)
        if emptyString.isEmpty {
            print("Nothing to see here")
        }
        
        
        
    }
    
    func insertString() {
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5) "
        print(message)
    }
    
    func quotationString() {
        let quotation = """



        The White Rabbit put on his spectacles.  "Where shall I begin,\
        please your Majesty?" he asked.\

        "Begin at the beginning," the King said gravely, "and go on\
        till you come to the end; then stop.\"
        \0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)
        """
        
        print(quotation)
        
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        // "Imageination is more important than knowledge" - Enistein
        let dollarSign = "\u{24}"             // $, Unicode 标量 U+0024
        let blackHeart = "\u{2665}"           // ♥, Unicode 标量 U+2665
        let sparklingHeart = "\u{1F496}"      // 💖, Unicode 标量 U+1F496
        let add = "\u{2b}"
        print(add)
    }
    
    func variableString() {
        var variableString = "LiZeKun"
        variableString += " Coding"
        // variableString 现在为"LiZeKun Coding"
        
        var constantString = "Swift"
        constantString += "OC"
        // 在 Objective-C 和 Cocoa 中，您需要通过选择两个不同的类(NSString和NSMutableString)来指定字符串是否可以被修改。
        
        
    }
    
    func indexString() {
        let greeting = "Guten Tag!"
        greeting[greeting.startIndex]
        // G
        greeting[greeting.index(before: greeting.endIndex)]
        // !
        greeting[greeting.index(after: greeting.startIndex)]
        // u
        let index = greeting.index(greeting.startIndex, offsetBy: 7)
        greeting[index]
        
        print(greeting[index])
        
        for index in greeting.indices {
            print("\(greeting[index]) ", terminator: "")
            print("\(greeting[index]) ")
            
        }
    }
    
    func insertRemoveString() {
        var welcome = "hello"
        welcome.insert("!", at: welcome.endIndex)
        // welcome now equals "hello!"

        welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
        
        
        
    }
    
    // MARK:遍历字符串
    func demo () {
        
        // NSString 不支持遍历
        let str:String  = "我要飞得更高"
        
        for c in str {
            print(c)
        }
        
    }
    // MARK:计算字符串长度
    func demo2 () {
        
        let  str = "hello world我"
        // 返回指定编码的对应的字节数量
        // UTF-8 的编码0-4个字节 ,每个汉字是3个字节
        print(str.lengthOfBytes(using: .utf32))
        // 字符串长度 - 返回字符的个数
        print(str.count)
        // 使用 NSString 中转
        // as 是做类型转换的 as(作为)
        let ocString = str as NSString
        
        print(ocString.length)

    }
    // MARK:拼接字符串
    func demo3 () {
        let name = "老王"
        let age = 20
        let title:String? = nil
        let point = CGPoint(x: 20, y: 20)
        
        let str = "\(name) \(age) \(title ?? "") \(point)"
        print(str)
  
        
    }
    
    // MARK:格式化
    func demo4 () {
        let h = 10
        let m = 1
        let s = 20
        
        print("\(h):\(m):\(s)")
        
        let str = String(format: "%ld:%ld:%ld", h,m,s)
        
        print(str)
        
        
    }
    
    // MARK:字符串子串
    func demo5 () {
        //1 建议用 NSString作为中转,应为  Swift String一在优化不好理解
        let str = "我们一起飞"
        
        
        let ocString = str as(NSString)
        
        let s1 = ocString.substring(with: NSMakeRange(0, 4))
        print(s1)
        
        
        //2 Swift3.0方法
        //                     ↘️字符串于原字符串没关系
        let s2 = str.substring(to: "我们".endIndex)
        let s3 = str.substring(to: "123".endIndex)
        
        
        print(s2 + "+" + s3 )
        
        
        // 比较方便 但是不好理解  偶尔使用方便
        guard let ss = str.range(of: "我们") else {
            return
        }
        print("-----")
        //一定找到的范围
        print(str.substring(with: ss))

        print(ss)
        
        
        
    }

}

