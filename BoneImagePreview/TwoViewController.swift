//
//  TwoViewController.swift
//  BoneImagePreview
//
//  Created by 俞旭涛 on 2017/5/28.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "父视图内图片放大"

        let view = UIView(frame: CGRect(x: 50, y: 200, width: 300, height: 400))
        view.backgroundColor = UIColor.yellow
        self.view.addSubview(view)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "11111")
        imageView.zoomImage()
        view.addSubview(imageView)
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
