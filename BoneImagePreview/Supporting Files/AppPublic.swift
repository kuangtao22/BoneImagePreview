//
//  AppPublic.swift
//  BoneImagePreview
//
//  Created by 俞旭涛 on 2017/5/27.
//  Copyright © 2017年 鱼骨头. All rights reserved.
//

import UIKit

let color_code_default = "#ff493e"  // 默认主色调颜色代码
let navColor_default = AppPublic.checkColor(code: color_code_default) //AppPublic.checkColor("#039be5")
let fontColor_dark = AppPublic.checkColor(code: "#333333")
let fontColor_darkGrey = AppPublic.checkColor(code: "#666666")
let fontColor_grey = AppPublic.checkColor(code: "#999999")
let fontColor_greyLight = AppPublic.checkColor(code: "#c9c9c9")

class AppPublic: NSObject {
    // 16进制颜色值转换为UIColor
    static func checkColor(code: String) -> UIColor {
        return checkColorWithAlpha(hexString: code, alpha: 1)
    }
    // 16进制颜色值转换为UIColor，透明度
    static func checkColorWithAlpha(hexString: String, alpha: CGFloat) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.characters.count < 6 {return UIColor.black}
        if cString.hasPrefix("0X") {cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))}
        if cString.hasPrefix("#") {cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))}
        
        if cString.characters.count != 6 {return UIColor.black}
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
}
