//
//  TimeExtension.swift
//  OneEye
//
//  Created by 鱼骨头 on 16/3/22.
//  Copyright © 2016年 鱼骨头. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    // 计算星期: 从0到6分别表示 周日 到周六
    public func dayOfWeek() -> String {
        let interval = self.timeIntervalSince1970;
        let days = Int(interval / Double(Time.day))
        
        switch (days - 3) % 7 {
        case 0: return "星期日"
        case 1: return "星期一"
        case 2: return "星期二"
        case 3: return "星期三"
        case 4: return "星期四"
        case 5: return "星期五"
        case 6: return "星期六"
        default: return "未知"
        }
    }
    
    /// Date转时间戳
    ///
    /// - Returns: 返回时间戳
    public func stamp() -> String {
        let timeInterval = self.timeIntervalSince1970
        return String(Int(timeInterval))
    }
}

struct Time {
    
    static let day = 86400 // 一天
    
    static func format(type: FormatType, time: String, format: String) -> String {
        switch type {
        case .Stamp:
            let dfmatter = DateFormatter()
            dfmatter.dateFormat = format
            let date = dfmatter.date(from: time)
            if date != nil {
                let dateStamp: TimeInterval = date!.timeIntervalSince1970
                let dateSt: Int = Int(dateStamp)
                return String(dateSt)
            }
            return ""
            
        case .String:
            let string = NSString(string: time)
            let timeSta: TimeInterval = string.doubleValue
            let dfmatter = DateFormatter()
            dfmatter.dateFormat = format
            
            let date = Date(timeIntervalSince1970: timeSta)
            return dfmatter.string(from: date as Date)
        }
    }
    /**
     获取当天时间
     :type: 时间格式/时间戳
     */
    static func today(type: FormatType = .String, format: String = "yyyyMMdd") -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = format
        let strNowTime = timeFormatter.string(from: date) as String
        
        switch type {
        case .String:
            return strNowTime
        case .Stamp:
            return self.format(type: type, time: strNowTime, format: format)
        }
    }
    
    // 获取昨日时间
    static func yesterday(type: FormatType = .String, format: String = "yyyyMMdd") -> String {
        let today = self.today(type: .String, format: format)
        let todayStamp = self.format(type: .Stamp, time: today, format: format)
        let yesterdayStamp = Int(todayStamp)! - day
        switch type {
        case .Stamp:
            return String(yesterdayStamp)
        case .String:
            let yesterday = self.format(type: type, time: String(yesterdayStamp), format: format)
            return yesterday
        }
    }
    
    // 转时间格式
    static func toDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // 替换时间标示符 
    // timeString:时间 format:转换的时间格式(如"-") oldFormat:替换的时间格式(如"-")
    static func timeFormat(timeString: String, oldFormat: String, format: String? = nil) -> String {
        // 字符串分割 st:需分割的字符串，identifier:分割符号
        let timeArray = timeString.components(separatedBy: oldFormat) // 根据符号‘oldFormat’分割字符串
        // 拼接字符串
        var string = ""
        
        if format != nil {
            for i in 0..<timeArray.count {
                string += timeArray[i] + format!
                if i == timeArray.count {
                    string += timeArray[i]
                }
            }
        } else {
            let formats = ["年","月","日","时","分","秒"]
            for i in 0..<timeArray.count {
                string += timeArray[i] + formats[i]
            }
        }
        return string
    }
    
    // 判断时间，前1年输出去年，前1年以上输出年份，今年输出月份与时间
    static func timeName(timeStamp: String) -> String {
        var name = ""
        if timeStamp == "" {
            return "无消费记录"
        }
        let year = Int(today(format: "yyyy"))! - Int(self.format(type: .String, time: timeStamp, format: "yyyy"))!
        switch year {
            case 0:
                let month = Int(today(format: "yyyyMM"))! - Int(self.format(type: .String, time: timeStamp, format:"yyyyMM"))!
                switch month {
                    case 0:
                        let day = Int(today(format: "yyyyMMdd"))! - Int(self.format(type: .String, time: timeStamp, format: "yyyyMMdd"))!
                        switch day {
                            case 0: name = "今日" + self.format(type: .String, time: timeStamp, format: "HH:mm")
                            case 1: name = "昨日" + self.format(type: .String, time: timeStamp, format: "HH:mm")
                            default: name = self.format(type: .String, time: timeStamp, format: "MM月dd日")
                        }
                    default: name = self.format(type: .String, time: timeStamp, format: "MM月dd日")
                }
            case 1: name = "去年"
            default: name = self.format(type: .String, time: timeStamp, format: "yyyy年")
        }
        return name
    }
    
    // 时间间隔
    // 参数: 
    // dayNum: 0今日、1昨日、前7日、前30天
    // timeStamp: true时间戳、false时间格式
    // format: 时间格式
    static func timeInterval(dayType: DayType, type: FormatType = .Stamp, format: String = "yyyy-MM-dd") -> (String, String) {

        let num = dayType.rawValue < 0 ? dayType.rawValue * -1 : dayType.rawValue // 判断如果传进来的数为负数，则自动转为正数
        
        var today = self.today(type: .Stamp, format: "yyyy-MM-dd") // 今日时间戳（0点0分）
        var beginTime = String(Int(today)! - day * num) // 获取开始时间戳
        var now = String(Int(NSDate().timeIntervalSince1970)) // 获取结束时间戳（当前时间戳,精确到分）

        switch type {
        case .Stamp: break
        case .String:
            today = self.format(type: .String, time: today, format: format)
            beginTime = self.format(type: .String, time: beginTime, format: format)
            now = self.format(type: .String, time: now, format: format + " HH:mm")
        }
        switch num {
            case 0: return (today, now)
            default: return (beginTime, today)
        }
    }
    
    enum DayType: Int {
        case Today = 0
        case Yesterday = -1
        case Week = 7
        case Month = 30
    }
    
    // 预定时间
    // 参数:
    // timeStamp: 初始时间
    // dayNum: 预定天数
    // 返回时间格式/时间戳
    static func allottedTime(type: FormatType, timeString: String? = nil, dayNum: Int, format: String = "yyyy-MM-dd") -> String {
        let today = (timeString == nil) ? self.today(type: .Stamp, format: "yyyy-MM-dd") : self.format(type: .Stamp, time:  timeString!, format: format)
        let newTime = "\(Int(today)! + dayNum * day)" // 获取预定时间戳
        switch type {
        case .Stamp:
            return newTime
        case .String:
            return self.format(type: .String, time: newTime, format: format)
        }
    }
    
    // 获取周
    // timeStamp: 传入时间戳
    // 返回 //0周六  1周日 2周一 3周二 4周三 5周四 6周五
    static func getWeekDay(timeStamp: String) -> Int {
        let timeInterval:TimeInterval = TimeInterval(timeStamp)!
        let date:NSDate? = NSDate(timeIntervalSince1970: timeInterval)

        if date != nil {
            let calendar:NSCalendar = NSCalendar.current as NSCalendar
            let dateComp:NSDateComponents = calendar.components(NSCalendar.Unit.NSWeekdayCalendarUnit, from: date! as Date) as NSDateComponents
            return dateComp.weekday
        }
        return 0
    }
    
    // 获取本周
    // 返回元组 (开始时间，结束时间)
    static func getThisWeek(type: FormatType = .Stamp) -> (String, String) {
        let nowStamp = String(format: "%d", Int(NSDate().timeIntervalSince1970)) // 获取结束时间戳（当前时间戳,精确到分）
        let todayWeek = self.getWeekDay(timeStamp: nowStamp)
        let todayStamp = self.format(type: .Stamp, time: self.today(format: "yyyy-MM-dd"), format: "yyyy-MM-dd")
        
        var beginTime = ""
        switch todayWeek - 2 {
        case -2:// 周六
            beginTime = String(format: "%d", Int(todayStamp)! - 5 * self.day)
        case -1:// 周日
            beginTime = String(format: "%d", Int(todayStamp)! - 6 * self.day)
        default:
            beginTime = String(format: "%d", Int(todayStamp)! - (todayWeek - 2) * self.day)
        }
        
        switch type {
        case .String:
            return (self.format(type: .Stamp, time: beginTime, format: "yyyy-MM-dd"), self.format(type: .String, time: nowStamp, format: "yyyy-MM-dd"))
        case .Stamp:
            return (beginTime, nowStamp)
        }
    }
    
    // 获取本月
    // 返回元组 (开始时间，结束时间)
    static func getThisMonth(type: FormatType = .Stamp) -> (String, String) {
        let nowStamp = String(format: "%d", Int(NSDate().timeIntervalSince1970)) // 获取结束时间戳（当前时间戳,精确到分）
        let todayMonth = self.format(type: .Stamp, time: self.today(format: "yyyy-MM"), format: "yyyy-MM")
        switch type {
        case .String:
            return (self.format(type: type, time: todayMonth, format: "yyyy-MM-dd"), self.format(type: type, time: nowStamp, format: "yyyy-MM-dd"))
        case .Stamp:
            return (todayMonth, nowStamp)
        }
    }
    
    // 根据传入时间，计算剩余天数
    static func getDayNum(timeStamp: String) -> Int {
        let timeString = self.format(type: .String, time: timeStamp, format: "yyyy-MM-dd")
        // 获取传入时间0点0分的时间戳
        if let time = Int(self.format(type: .Stamp, time: timeString, format: "yyyy-MM-dd")) {
            let todayStamp = Int(self.today(type: .Stamp, format: "yyyy-MM-dd"))
            return (time - todayStamp!) / self.day
        }
        
        return 0
    }
    
    // 获取两个时间差
    static func getDateNum(from: Date, to: Date) -> Int {
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var result = gregorian!.components(NSCalendar.Unit.day, from: from, to: to, options: NSCalendar.Options(rawValue: 0))
        if let num = result.day {
            if num < 0 {
                return -num + 1
            } else {
                return num + 1
            }
        }
        return 0
    }
    
    // 获取推算时间
    static func getAddDay(from: Date, num: Int) -> Date {
        let calendar = Calendar.current
        let currentDate = from
        var newDateComponents = DateComponents()
        newDateComponents.day = num
        return calendar.date(byAdding: newDateComponents, to: currentDate) ?? Date()
    }
    
    /// 时间戳转Date
    ///
    /// - Parameter to: 时间戳
    /// - Returns: Date
    static func stamp(to: String) -> Date? {
        if let timeInterval = TimeInterval(to) {
            let date = Date(timeIntervalSince1970: timeInterval)
            return date
        } else {
            return nil
        }
    }
    
    enum FormatType {
        case String // 时间格式
        case Stamp  // 时间戳
    }
}
    
    
    
    
