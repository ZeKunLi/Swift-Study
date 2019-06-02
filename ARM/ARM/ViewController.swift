//
//  ViewController.swift
//  ARM
//
//  Created by 李泽昆 on 17/3/21.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var contentScrollView: UIScrollView!

    
    @IBOutlet weak var titleScrollView: UIView!
    
    var titleLabels = [String]()
    var bottom:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpChildViewController()
        self.setUpTitleLabel()
        
        // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
        // 不想要添加
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        contentScrollView.delegate = self;
    }

    func setUpChildViewController() -> () {
        
        let hotVC = HotViewController()
        hotVC.title = "推荐"
        self.addChildViewController(hotVC)
        
        let hotVC1 = RecommendedViewController()
        hotVC1.title = "热门"
        self.addChildViewController(hotVC1)
        
        let hotVC2 = NewViewController()
        hotVC2.title = "最新"
        self.addChildViewController(hotVC2)
        
    }
// 添加所有子控制器对应标题
    let kScreenHeight = UIScreen.main.bounds.size.height
    let kScreenWidth = UIScreen.main.bounds.size.width
    func setUpTitleLabel() -> () {
        let count:NSInteger = self.childViewControllers.count

        
        var labelX:CGFloat = 0
        let labelY:CGFloat = 0
        let labelH:CGFloat = 44
        
        bottom = UILabel(frame: CGRect(x: 20, y: labelH - 3, width: 100, height: 3))
        bottom?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        titleScrollView.addSubview(bottom!)
        
        
        for i in 0..<count {
//            let labelW:CGFloat =  CGFloat(kScreenWidth / CGFloat(i+1))
            let vc:UIViewController = self.childViewControllers[i]
            labelX = CGFloat(i) * CGFloat(kScreenWidth / CGFloat(count))
            // 创建 UIlab
            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: CGFloat(kScreenWidth / CGFloat(count)), height: labelH))
            label.text = vc.title
            label.tag = i
            label.highlightedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
        
            titleLabels.append(vc.title!)
            
   
            // 添加label到标题滚动条上
            self.titleScrollView.addSubview(label)
            

            let tap = UITapGestureRecognizer(target: self, action: #selector(titleClick))
            
            label.addGestureRecognizer(tap)
            
            
            
            if i == 0 {
                self.titleClick(tap: tap)
            }
            
    
        }
        
        
    }

    func titleClick(tap:UITapGestureRecognizer) -> () {
        // 获取选中 lable
        let selLab = tap.view
        // 获取下标
        let index:NSInteger = (selLab?.tag)!
        // 2.1 计算滚动的位置
        let offsetX:CGFloat = CGFloat(index) * kScreenWidth
        // 修改 bottom的 frame
        UIView.animate(withDuration: 0.5) { 
            
            self.bottom?.frame.origin.x = (120 * CGFloat(index) ) + 20
        }
        contentScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        self.showVC(index: index)
        
        
    }
    
    // 显示控制器的view
    
    func showVC(index:NSInteger) -> () {
        print(index)
        
        let vc:UIViewController = self.childViewControllers[index]
        contentScrollView.addSubview(vc.view)
        // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
//        if vc.isViewLoaded {
//            return
//        }
        vc.view.frame = CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight)
        
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("haha")
    }
    
    
}

