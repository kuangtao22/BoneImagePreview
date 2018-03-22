//
//  BonePreview.swift
//  BoneImagePreview
//
//  Created by 俞旭涛 on 2017/5/27.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

class BoneZoom: UIView {
    
    weak var delegate: BoneZoomDelegate?
    
    // 最大的缩放比例
    fileprivate var maxScale: CGFloat {
        get {
            let bounds = self.oldImage.bounds
            let imageHeight = bounds.height / bounds.width * self.frame.width
            return self.frame.height / imageHeight
        }
    }
    // 最小的缩放比例
    fileprivate let minScale: CGFloat = 1.0
    
    fileprivate var newImage: UIImageView!  // 新的图片
    fileprivate var oldImage: UIImageView!  // 原图片
    
    fileprivate let animDuration: TimeInterval = 0.3 // 动画时长
    fileprivate var scale: CGFloat = 1.0    // 当前的缩放比例
    fileprivate var touchX: CGFloat = 0.0   // 双击点的X坐标
    fileprivate var touchY: CGFloat = 0.0   // 双击点的Y坐标
    fileprivate var isHideAnimate = false   // 是否隐藏动画
    
    convenience init(imageView: UIImageView) {
        self.init(frame: UIScreen.main.bounds)
        // 保存原始frame
        self.oldImage = imageView

        // 隐藏状态栏
        UIApplication.shared.isStatusBarHidden = true
        self.navView.titleLabel.text = "预览"
        self.addSubview(self.scrollView)

        self.newImage = UIImageView(image: imageView.image)
        self.newImage.frame = CGRect(origin: self.oldPoint, size: self.oldImage.bounds.size)

        self.scrollView.addSubview(self.newImage)
        
        // 设置手势单击
        let oneTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(sender:)))
        oneTapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(oneTapGesture)
        
        // 设置手势双击
        let twoTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(sender:)))
        twoTapGesture.numberOfTapsRequired = 2
        self.scrollView.addGestureRecognizer(twoTapGesture)
        oneTapGesture.require(toFail: twoTapGesture)
        
        self.addSubview(self.navView)
    }

    // 原位置
    fileprivate lazy var oldPoint: CGPoint = {
        let superview = self.oldImage.superview
        let view = self.getCurrentVC()?.view
        let frame = superview?.convert(self.oldImage.frame, to: view)
        return frame?.origin ?? CGPoint.zero
    }()

    fileprivate lazy var navView: BoneZoomNav = {
        let navView = BoneZoomNav()
        navView.saveBtn.addTarget(self, action: #selector(self.saveAction), for: UIControlEvents.touchUpInside)
        navView.closeBtn.addTarget(self, action: #selector(self.hideAnimate), for: UIControlEvents.touchUpInside)
        navView.isShow = true
        return navView
    }()

    
    /// 滚动视图
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.minimumZoomScale = self.minScale
        scrollView.maximumZoomScale = self.maxScale
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.black
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        return scrollView
    }()
    
    /// 显示动画
    func showAnimate() {
        UIView.animate(
            withDuration: self.animDuration,
            delay: 0,
            options: UIViewAnimationOptions.beginFromCurrentState,
            animations: {
                self.newImage.frame.size.width = self.scrollView.frame.width
                self.newImage.frame.size.height = self.oldImage.frame.height / self.oldImage.frame.width * self.scrollView.frame.width
                self.newImage.frame.origin.x = 0
                self.newImage.frame.origin.y = (self.scrollView.frame.height - self.newImage.frame.height) / 2
        }) { (finished) in
            
        }
    }
    
    /// 隐藏动画
    @objc fileprivate func hideAnimate() {
        self.navView.isShow = false
        self.navView.isHidden = true
        self.scrollView.backgroundColor = UIColor.clear
        UIView.animate(
            withDuration: self.animDuration,
            delay: 0,
            options: UIViewAnimationOptions.beginFromCurrentState,
            animations: {
                self.newImage.frame = CGRect(origin: self.oldPoint, size: self.oldImage.frame.size)
                UIApplication.shared.isStatusBarHidden = false
                
        }) { (finished) in
            self.oldImage.isHidden = false
            self.scale = self.minScale
            self.scrollView.removeFromSuperview()
            self.navView.removeFromSuperview()
            self.removeFromSuperview()
            
        }
    }
    
    /// 保存图片到相册
    @objc private func saveAction() {
        let item: [MMPopupItem] = [MMItemMake("保存图片到相册", .highlight, { (index) in
            if let image = self.delegate?.getZoomImage() {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if let image = self.newImage.image {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                BoneShowHUD.shared.show(status: "保存失败", showType: .Error)
            }
        })]
        BoneShowHUD.shared.sheet(title: "操作", items: item)
    }
    
    fileprivate var isNavShow: Bool {
        get {
            return self.navView.transform.ty == 0
        }
        set {
            self.navView.animate(isShow: newValue)
        }
    }
    
    // 手势点击事件
    @objc private func tapGestureAction(sender: UITapGestureRecognizer) {
        // 显示隐藏导航
        if sender.numberOfTapsRequired == 1 {
            self.navView.isShow = !self.isNavShow

        } else if sender.numberOfTapsRequired > 1 {
            self.touchX = sender.location(in: sender.view).x
            self.touchY = sender.location(in: sender.view).y
            if self.scale > 1.0 {
                self.scale = 1.0
                self.scrollView.setZoomScale(self.scale, animated: true)
            } else {
                self.scale = self.maxScale
                self.scrollView.setZoomScale(self.maxScale, animated: true)
            }
        }
    }
    
    // 保存图片
    @objc private func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:AnyObject) {
        self.delegate?.boneZoom(self, SaveImageToAlbums: image, status: (error == nil))
        if error != nil {
            BoneShowHUD.shared.show(status: "保存失败", showType: .Error)
        } else {
            BoneShowHUD.shared.show(status: "保存成功", showType: .Info)
        }
    }
    
    deinit {
        print("销毁")
    }
}

extension BoneZoom: UIScrollViewDelegate {
    
    /// 设置要缩放的 scrollView 上面的子视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.newImage
    }
    
    /// 当scrollView缩放时，调用该方法
    ///
    /// - 计算保持newImage在放大过程中的位置居中
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if self.frame.height > self.newImage.frame.height {
            self.newImage.frame.origin.y = (self.frame.height - self.newImage.frame.height) / 2
        } else {
            self.newImage.frame.origin.y = 0
        }
    }
    
    /// 保存当前缩放倍数
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.scale = scale
    }
    
    /// 当scrollView滑动时
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let top = abs(scrollView.contentOffset.y)
        self.navView.isShow = top < 30
        if !self.isHideAnimate {
            scrollView.backgroundColor = BoneZoom.black(alpha: (70-top) / 70)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let top = abs(scrollView.contentOffset.y)
        self.isHideAnimate = top > 70

        if self.isHideAnimate {
            guard self.scale == 1 else {
                return
            }
            self.hideAnimate()
        }
    }
}
