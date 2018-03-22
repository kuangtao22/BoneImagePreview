//
//  BoneZoomDelegate.swift
//  TransbellCRM
//
//  Created by 俞旭涛 on 2017/12/13.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

protocol BoneZoomDelegate: NSObjectProtocol {
    
    /// 保存图片到相册
    func boneZoom(_ zoomView: BoneZoom, SaveImageToAlbums: UIImage, status: Bool)
    
    /// 获取放大图片
    func getZoomImage() -> UIImage?
    
}
