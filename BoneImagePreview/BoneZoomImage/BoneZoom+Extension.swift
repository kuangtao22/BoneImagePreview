//
//  BoneZoom+Extension.swift
//  BoneImagePreview
//
//  Created by 俞旭涛 on 2017/5/27.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

// MARK: - 使用方法
extension UIImageView {

    
    /// 使用该方法开启图片放大功能
    func zoomImage() {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(showZoomImageAction))
        self.addGestureRecognizer(tap)
    }
    
    /// 显示放大图片事件
    @objc private func showZoomImageAction() {
        let zoom = BoneZoom(imageView: self)
        self.isHidden = true
        zoom.show()
    }

}

extension BoneZoom {
    
    /// 黑色
    ///
    /// - Parameter alpha: 透明度
    /// - Returns: 黑色
    static func black(alpha: CGFloat) -> UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
    }
    
    /// 显示图片放大器
    public func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.showAnimate()
    }
    
    
    /// 获取当前视图控制器
    ///
    /// - Returns: 视图控制器
    public func getCurrentVC() -> UIViewController? {
        
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for  tempwin in windows {
                if tempwin.windowLevel == UIWindowLevelNormal {
                    window = tempwin
                    break
                }
            }
        }
        let frontView = (window?.subviews)![0]
        let nextResponder = frontView.next

        if nextResponder?.isKind(of: UIViewController.classForCoder()) == true{
            return nextResponder as? UIViewController
            
        } else if nextResponder?.isKind(of: UINavigationController.classForCoder()) == true{
            return (nextResponder as! UINavigationController).visibleViewController
            
        } else {
            if window?.rootViewController is UINavigationController{
                //只有这个是显示的controller 是可以的必须有nav才行
                return (window?.rootViewController as? UINavigationController)?.visibleViewController
                
            } else if (window?.rootViewController) is ViewController {
                //不行只是最三个开始的页面
                return ((window?.rootViewController) as! UITabBarController).selectedViewController!
            }
            return window?.rootViewController
        }
    }
}


