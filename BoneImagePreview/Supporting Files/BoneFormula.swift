//
//  BoneAlgorithm.swift
//  EasyPayStore
//
//  Created by 俞旭涛 on 2017/2/12.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

/*******
 - 尺寸规范:
 - 命名规范: 页面名称_viewName_sizeType
 */
let screen_width = UIScreen.main.bounds.size.width // 屏幕宽度
let screen_height = UIScreen.main.bounds.size.height // 屏幕高度
let screen_nav_height: CGFloat = 44 // 导航高度
let screen_statusBar_height = UIApplication.shared.statusBarFrame.size.height // 状态栏高度

class BoneFormula: NSObject {
    /**
     ** 控件位置算法
     ** rank：排名
     ** colNum: 横排数量
     ** spacing：间隔
     ** size：大小
     */
    static func viewOrigin(rank: Int, colNum: Int, spacing: CGFloat, size: CGSize) -> CGPoint {
        let x = CGFloat(rank % colNum) * (size.width + spacing) + spacing
        let y = CGFloat(rank / colNum) * (size.height + spacing) + spacing
        return CGPoint(x: x, y: y)
    }
    
    static func autoHeight(height: CGFloat) -> CGFloat {
        return screen_width * height / 320
    }
}
