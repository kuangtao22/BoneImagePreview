//
//  BoneShowHUD.swift
//  EasyPayStore-IOS
//
//  Created by 俞旭涛 on 2017/1/18.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

class BoneShowHUD: NSObject {
    typealias Show = SVProgressHUD
    
    override init() {
        Show.dismiss(withDelay: 2)
//        Show.setDefaultStyle(SVProgressHUDStyle.dark)
//        Show.setDefaultMaskType(SVProgressHUDMaskType.black)
        MMPopupWindow.shared().touchWildToHide = true
        MMPopupWindow.shared().mm_dimBackgroundBlurEnabled = false
    }
    
    static var shared = BoneShowHUD()
    
    // 显示类型
    public enum ShowType {
        case Info       // 提示
        case Loading    // 加载
        case Error      // 错误
    }
    
    // 显示
    public func show(status: String, showType: ShowType, maskType: SVProgressHUDMaskType? = nil) {
        switch showType {
        case .Info:
            Show.setDefaultMaskType(maskType ?? .none)
            Show.showInfo(withStatus: status)
            
        case .Loading:
            Show.dismiss(withDelay: 20)
            Show.setDefaultMaskType(maskType ?? .clear)
            Show.show(withStatus: status)

        case .Error:
            Show.setDefaultMaskType(maskType ?? .none)
            Show.showError(withStatus: status)
        }
    }
    
    // 消失
    public func dismiss() {
        Show.dismiss()
    }

    // 自定义aler
    public func alert(title: String?, detail: String?, items: [MMPopupItem]?) {
        guard let items = items else {
            let alertView = MMAlertView(confirmTitle: title, detail: detail)
            alertView?.withKeyboard = false
            alertView?.show()
            return
        }
        let alertView = MMAlertView(title: title, detail: detail, items: items)
        alertView?.withKeyboard = false
        alertView?.show()
    }
    
    public func sheet(title: String?, items: [MMPopupItem]) {
        let sheetView = MMSheetView(title: title, items: items)
        sheetView?.withKeyboard = false
        sheetView?.show()
    }
    
    // 输入弹出框
    public func alertText(title: String?, detail: String?, placeholder: String, keyboardType: UIKeyboardType, callback: @escaping (_ text: String)->()) {
        let alertView = MMAlertView(inputTitle: title, detail: detail, placeholder: placeholder) { (text) in
            callback(text ?? "")
        }
        alertView?.withKeyboard = true
        alertView?.inputView.keyboardType = keyboardType
        alertView?.show()
    }

    // 时间选择
    public func dateAlert(type: UIDatePickerMode, time: String, minStamp: String?, maxStamp: String?, callback: @escaping (_ date: String)->()) {
        let dateView = BoneDateSheet(type: type, time: time) { (date) in
            callback(date)
        }
        dateView.minDateStamp = minStamp
        dateView.maxDateStamp = maxStamp
        dateView.show()
    }
}
