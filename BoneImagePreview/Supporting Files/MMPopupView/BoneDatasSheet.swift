//
//  MMDataView.swift
//  YichuanCRM
//
//  Created by 俞旭涛 on 2017/4/3.
//  Copyright © 2017年 俞旭涛. All rights reserved.
//

import UIKit

class BoneDatasSheet: MMPopupView {

    typealias MMPopupInputHandler = (_ row: Int, _ component: Int) -> ()
    
    var inputHandler: MMPopupInputHandler?
    
    var btnCancel: UIButton!    // 取消按钮
    var btnConfirm: UIButton!   // 确定按钮
    var picker: UIPickerView!
    var data = (row: 0, component: 0)
    
    fileprivate var dataArray: [[String]]!
    
    convenience init(title: String, dataArray: [[String]], inputHandler: MMPopupInputHandler?) {
        self.init()
        self.dataArray = dataArray
        self.type = .sheet
        self.inputHandler = inputHandler
        self.backgroundColor = UIColor.white
        self.withKeyboard = false
        
        self.mas_makeConstraints { (make) in
            _ = make?.width.mas_equalTo()(screen_width)
            _ = make?.height.mas_equalTo()(200)
        }
        
        self.btnCancel = UIButton.mm_button(withTarget: self, action: #selector(BoneDatasSheet.actionHide(button:))) as! UIButton!
        self.btnCancel.setTitleColor(fontColor_dark, for: UIControlState.normal)
        self.btnCancel.setTitle("取消", for: UIControlState.normal)
        self.btnCancel.tag = 0
        self.addSubview(self.btnCancel)
        self.btnCancel.mas_makeConstraints { (make) in
            _ = make?.size.mas_equalTo()(CGSize(width: 80, height: 50))
            _ = make?.left.top().equalTo()(self)
        }
        
        self.btnConfirm = UIButton.mm_button(withTarget: self, action: #selector(BoneDatasSheet.actionHide(button:))) as! UIButton!
        self.btnConfirm .setTitle("确定", for: UIControlState.normal)
        self.btnConfirm.tag = 1
        self.btnConfirm.setTitleColor(navColor_default, for: UIControlState.normal)
        self.addSubview(self.btnConfirm)
        self.btnConfirm.mas_makeConstraints { (make) in
            _ = make?.size.mas_equalTo()(CGSize(width: 80, height: 50))
            _ = make?.right.top().equalTo()(self)
        }
        
        self.picker = UIPickerView()
        self.picker.delegate = self
        self.picker.dataSource = self
        self.addSubview(self.picker)
        self.picker.mas_makeConstraints { (make) in
            _ = make?.edges.equalTo()(self)?.insets()(UIEdgeInsetsMake(50, 0, 0, 0))
        }
    }
    
    @objc private func actionHide(button: UIButton) {
        if (button.tag == 0) {
            self.hide()
        } else {
            self.inputHandler?(self.data.row, self.data.component)
            self.hide()
        }
    }
}

extension BoneDatasSheet: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.dataArray.count
    }
    
    //设置行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArray[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataArray[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        print(component)
        print(row)
        self.data = (row, component)
    }
}
