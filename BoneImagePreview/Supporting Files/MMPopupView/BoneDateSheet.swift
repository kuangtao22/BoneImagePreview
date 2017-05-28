//
//  BoneDateSheet.swift
//  YichuanCRM
//
//  Created by 俞旭涛 on 2017/4/25.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

class BoneDateSheet: MMPopupView {

    typealias MMPopupInputHandler = (_ date: String) -> ()
    
    /// 最小时间戳
    public var minDateStamp: String? {
        didSet {
            if let date = self.minDateStamp {
                self.datePicker.minimumDate = Time.stamp(to: date)
            }
        }
    }
    
    /// 最大时间戳
    public var maxDateStamp: String? {
        didSet {
            if let date = self.maxDateStamp {
                self.datePicker.maximumDate = Time.stamp(to: date)
            }
        }
    }
    
    private var inputHandler: MMPopupInputHandler?
    private var btnCancel: UIButton!    // 取消按钮
    private var btnConfirm: UIButton!   // 确定按钮
    private var btnClean: UIButton!     // 清除按钮
    private var datePicker: UIDatePicker!
    private var time: String = ""
    
    convenience init(type: UIDatePickerMode, time: String = Time.today(type: .Stamp, format: "yyyy-MM-dd HH:mm:ss"), handler: MMPopupInputHandler?) {
        self.init()
        
        self.backgroundColor = UIColor.white
        self.inputHandler = handler
        self.type = .sheet
        self.withKeyboard = false
        
        self.mas_makeConstraints { (make) in
            _ = make?.width.mas_equalTo()(screen_width)
            _ = make?.height.mas_equalTo()(250)
        }
        
        self.btnCancel = UIButton.mm_button(withTarget: self, action: #selector(BoneDateSheet.actionHide(button:))) as! UIButton!
        self.btnCancel.setTitleColor(fontColor_dark, for: UIControlState.normal)
        self.btnCancel.setTitle("取消", for: UIControlState.normal)
        self.btnCancel.tag = 0
        self.addSubview(self.btnCancel)
        self.btnCancel.mas_makeConstraints { (make) in
            _ = make?.size.mas_equalTo()(CGSize(width: 80, height: 50))
            _ = make?.left.top().equalTo()(self)
        }
        
        self.btnClean = UIButton.mm_button(withTarget: self, action: #selector(BoneDateSheet.actionHide(button:))) as! UIButton!
        self.btnClean.setTitle("清除", for: UIControlState.normal)
        self.btnClean.tag = 1
        self.btnClean.setTitleColor(fontColor_dark, for: UIControlState.normal)
        self.addSubview(self.btnClean)
        self.btnClean.mas_makeConstraints { (make) in
            _ = make?.size.mas_equalTo()(CGSize(width: 80, height: 50))
            _ = make?.centerX.top().equalTo()(self)
        }
        
        self.btnConfirm = UIButton.mm_button(withTarget: self, action: #selector(BoneDateSheet.actionHide(button:))) as! UIButton!
        self.btnConfirm .setTitle("确定", for: UIControlState.normal)
        self.btnConfirm.tag = 2
        self.btnConfirm.setTitleColor(navColor_default, for: UIControlState.normal)
        self.addSubview(self.btnConfirm)
        self.btnConfirm.mas_makeConstraints { (make) in
            _ = make?.size.mas_equalTo()(CGSize(width: 80, height: 50))
            _ = make?.right.top().equalTo()(self)
        }
        
        self.datePicker = UIDatePicker()
        self.datePicker.addTarget(self, action: #selector(BoneDateSheet.datePickerValueChanged(datePicker:)), for: UIControlEvents.valueChanged)
        self.datePicker.datePickerMode = type
        if let time = Time.stamp(to: time) {
            self.datePicker.setDate(time, animated: true)
        }
        self.addSubview(self.datePicker)
        
        self.datePicker.mas_makeConstraints { (make) in
            _ = make?.edges.equalTo()(self)?.insets()(UIEdgeInsetsMake(50, 0, 0, 0))
        }
    }
    
    @objc private func actionHide(button: UIButton) {
        if button.tag == 0 {
            self.hide()
            
        } else if button.tag == 1 {
            self.inputHandler?("")
            self.hide()
            
        } else if button.tag == 2 {
            self.inputHandler?(self.time.isEmpty ? self.datePicker.date.stamp() : self.time)
            self.hide()
        }
    }
    
    @objc private func datePickerValueChanged(datePicker: UIDatePicker) {
        self.time = datePicker.date.stamp()
    }
}
