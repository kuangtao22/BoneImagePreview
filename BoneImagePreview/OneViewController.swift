//
//  OneViewController.swift
//  BoneImagePreview
//
//  Created by 俞旭涛 on 2017/5/28.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.imageView = UIImageView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        self.imageView.image = UIImage(named: "11111")
        self.imageView.zoomImage()
        self.view.addSubview(self.imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
