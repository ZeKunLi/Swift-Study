//
//  DetailsViewController.swift
//  ARM
//
//  Created by 李泽昆 on 17/3/21.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var moviePlay: UIImageView!
    //初始化解码对象
    var decode = decodeSDK()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
       
        //解码初始化
        decode = decodeSDK()
        
        //初始化
        decode.initDevice()
        
        //登录
        decode.login("192.168.1.108", 3357, 3356)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func backClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func playClick(_ sender: Any) {
        decode.realPlayChannle(0, 0, view.window, moviePlay)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
