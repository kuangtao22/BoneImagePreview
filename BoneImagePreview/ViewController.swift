//
//  ViewController.swift
//  BoneImagePreview
//
//  Created by 俞旭涛 on 2017/5/27.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    let titleArray = ["图片无父视图",
                      "父视图内的图片放大",
                      "表格Cell内的图片放大"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "BoneZoom图片放大demo"
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        cell?.textLabel?.text = self.titleArray[indexPath.row]
        
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = OneViewController()
            vc.title = self.titleArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 1 {
            let vc = TwoViewController()
            vc.title = self.titleArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 2 {
            let vc = ThreeViewController()
            vc.title = self.titleArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

