//
//  ThreeViewController.swift
//
//  Created by 俞旭涛 on 2017/5/28.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class ThreeViewController: UIViewController {

    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let tableView = UITableView(frame: CGRect(x: 0, y: 10, width: screen_width, height: screen_height - 10))
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ThreeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            self.imageView.image = UIImage(named: "11111")
            cell?.contentView.addSubview(self.imageView)
        }
        
        
        self.imageView.zoomImage()
        
        return cell!
    }
}

extension ThreeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
