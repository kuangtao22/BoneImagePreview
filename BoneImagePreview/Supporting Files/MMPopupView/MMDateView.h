//
//  MMDateView.h
//  MMPopupView
//
//  Created by Ralph Li on 9/7/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMPopupView.h"

typedef void(^MMPopupInputHandler)(NSString *time);

@interface MMDateView : MMPopupView

typedef NS_ENUM(NSInteger, MMDateViewType) {
    MMDateViewTypeTime,
    MMDateViewTypeData,
    MMDateViewTypeDateAndTime,
};

- (instancetype) initWithInputMinimumDate:(NSDate *)minimumDate   // 最小时间
                              maximumDate:(NSDate *)maximumDate   // 最大时间
                                     time:(NSString *)time
                                     type:(MMDateViewType)type
                                  handler:(MMPopupInputHandler)inputHandler;  // 回调
// todo

@end
