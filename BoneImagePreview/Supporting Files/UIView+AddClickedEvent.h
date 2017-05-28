//
//  UIView+AddClickedEvent.h
//  AddClickedEvent
//
//  Created by HEYANG on 16/6/6.
//  Copyright © 2016年 HeYang. All rights reserved.
//
//  github:https://github.com/HeYang123456789
//  blog  :http://www.cnblogs.com/goodboy-heyang
//


#import <UIKit/UIKit.h>

@interface UIView (AddClickedEvent)

- (void)addClickedBlock:(void(^)(id obj))tapAction;

@end
