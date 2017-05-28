//
//  BoneZoomHead.swift
//  BoneImagePreview
//
//  Created by 俞旭涛 on 2017/5/27.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

extension BoneZoomNav {
    
    /// 关闭事件
    ///
    /// - Parameter cellback: 回调
    public func close(cellback: @escaping TouchUpInside) {
        self.onClick = cellback
    }
}

class BoneZoomNav: UIView {
    
    /// 标题
    public var titleLabel: UILabel!
    
    /// 显示/隐藏
    public var isShow: Bool {
        get {
            return self.transform.ty == 0
        }
        set {
            self.animate(isShow: newValue)
        }
    }
    
    typealias TouchUpInside = (_ button: UIButton) -> Void
    fileprivate var onClick: TouchUpInside?
    private var statusBar_height: CGFloat = UIApplication.shared.statusBarFrame.size.height
    private let screen_nav_height: CGFloat = 50 // 导航高度
    
    
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: 0))
        self.frame.size.height = statusBar_height + screen_nav_height
        self.backgroundColor = BoneZoom.black(alpha: 0.4)
        
        if ((UIDevice.current.systemVersion as NSString).floatValue >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1) {
            
            self.statusBar.frame.size.height = self.statusBar_height
            self.statusBar.backgroundColor = UIColor.clear
            self.addSubview(self.statusBar)
        }
        
        self.addSubview(self.navView)
        self.navView.addSubview(self.closeBtn)
        self.navView.addSubview(self.saveBtn)
        
        // 导航条标题
        let titleLeft = self.closeBtn.frame.width + 30
        self.titleLabel = UILabel(frame: CGRect(x: titleLeft, y: 0, width: self.navView.frame.width - titleLeft * 2, height: self.navView.frame.height))
        self.titleLabel.font = UIFont.systemFont(ofSize: 17)
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.textColor = UIColor.white
        self.navView.addSubview(self.titleLabel)
        
    }
    
    /// 关闭按钮
    private lazy var closeBtn: UIButton = {
        let origin = CGPoint(x: 15, y: (self.navView.frame.height - 30) / 2)
        let btn = UIButton(frame: CGRect(origin: origin, size: CGSize(width: 30, height: 30)))
        btn.setImage(UIImage(named: "IconBoneZoom.bundle/close"), for: UIControlState.normal)
        btn.tag = 0
        btn.addTarget(self, action: #selector(navAction(button:)), for: UIControlEvents.touchUpInside)
        return btn
    }()

    /// 保存按钮
    private lazy var saveBtn: UIButton = {
        let origin = CGPoint(x: screen_width - 15 - 30, y: (self.navView.frame.height - 30) / 2)
        let btn = UIButton(frame: CGRect(origin: origin, size: CGSize(width: 30, height: 30)))
        btn.setImage(UIImage(named: "IconBoneZoom.bundle/save"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(navAction(button:)), for: UIControlEvents.touchUpInside)
        btn.tag = 1
        return btn
    }()

    /// 状态栏
    lazy var statusBar: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0))
        return view
    }()
    
    /// 导航条
    lazy var navView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.statusBar.frame.height, width: self.frame.width, height: self.screen_nav_height))
        return view
    }()
    
    /// 关闭事件/保存图片
    @objc private func navAction(button: UIButton) {
        self.onClick?(button)
    }
   
    
    /// 显示/隐藏动画
    ///
    /// - Parameter isShow: <#isShow description#>
    private func animate(isShow: Bool) {
        UIView.animate(withDuration: 0.2) {
            if isShow {
                self.transform = CGAffineTransform.identity
            } else {
                self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            }
        }
    }
}
