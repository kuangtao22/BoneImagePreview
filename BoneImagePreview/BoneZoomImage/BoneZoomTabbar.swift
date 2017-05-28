//
//  BoneZoomTabbar.swift
//  BoneImagePreview
//
//  Created by 俞旭涛 on 2017/5/27.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class BoneZoomTabbar: UIView {
    
    public var titleLabel: UILabel! // 标题
    public var msgLabel: UILabel!   // 简介

    convenience init() {
        self.init(frame: CGRect(x: 0, y: screen_height - 200, width: screen_width, height: 200))
        
        self.titleLabel = UILabel(frame: CGRect(x: 15, y: 15, width: screen_width - 30, height: 15))
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(self.titleLabel)
        
        self.msgLabel = UILabel(frame: CGRect(x: self.titleLabel.frame.origin.x, y: self.titleLabel.frame.origin.y + self.titleLabel.frame.height + 10, width: self.titleLabel.frame.width, height: 14))
        self.msgLabel.textColor = UIColor.white
        self.msgLabel.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.msgLabel)
    }

}
