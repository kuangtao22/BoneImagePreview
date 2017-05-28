//
//  MMDateView.m
//  MMPopupView
//
//  Created by Ralph Li on 9/7/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "MMDateView.h"
#import "MMPopupDefine.h"
#import "MMPopupCategory.h"
#import "Masonry/Masonry.h"

@interface MMDateView()

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, strong) NSString *dateFormat;
@property (nonatomic, copy) MMPopupInputHandler inputHandler;

@end

@implementation MMDateView



- (instancetype)initWithInputMinimumDate:(NSDate *)minimumDate
                             maximumDate:(NSDate *)maximumDate
                                    time:(NSString *)time
                                    type:(MMDateViewType)type
                                 handler:(MMPopupInputHandler)inputHandler
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeSheet;
        self.inputHandler = inputHandler;
        self.backgroundColor = [UIColor whiteColor];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(216+50);
        }];
        
        self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(actionHide:)];
        [self addSubview:self.btnCancel];
        [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.left.top.equalTo(self);
        }];
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:MMHexColor(0xE76153FF) forState:UIControlStateNormal];
        self.btnCancel.tag = 0;
        
        self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(actionHide:)];
        [self addSubview:self.btnConfirm];
        [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.right.top.equalTo(self);
        }];
        [self.btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        self.btnConfirm.tag = 1;
        [self.btnConfirm setTitleColor:MMHexColor(0xE76153FF) forState:UIControlStateNormal];
        
        self.datePicker = [UIDatePicker new];
        [self.datePicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];

        switch (type) {
            case MMDateViewTypeTime:
                self.datePicker.datePickerMode = UIDatePickerModeTime;
                self.dateFormat = @"HH:mm";
                break;
                
            case MMDateViewTypeData:
                self.datePicker.datePickerMode = UIDatePickerModeDate;
                self.dateFormat = @"yyyy-MM-dd";
                break;
            case MMDateViewTypeDateAndTime:
                self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
                self.dateFormat = @"yyyy-MM-dd HH:mm";
                break;
        }
        
        
        NSDate *date;
        if ((time != nil) && (![time isEqual: @""])){
            // 转换NSDate格式
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:self.dateFormat];
            date = [dateFormatter dateFromString:time];
            [self.datePicker setDate:date animated:YES]; // 初始化时间
            self.timeString = time;
        } else {
            date = [NSDate date];
            [self.datePicker setDate:date animated:YES]; // 初始化时间
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
            
            [dateFormatter setDateFormat:self.dateFormat];//设定时间格式,这里可以设置成自己需要的格式
            NSString *today = [dateFormatter stringFromDate:date];
            self.timeString = today;
        }
        
        if (maximumDate != nil) {
            [self.datePicker setMaximumDate:maximumDate];// 设置显示最大时间
        }
        if (minimumDate != nil) {
            [self.datePicker setMinimumDate:minimumDate];// 设置显示最小时间
        }
        
        [self addSubview:self.datePicker];

        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
    }
    
    return self;
}

- (void)oneDatePickerValueChanged:(UIDatePicker *) sender {
    NSDate *select = [sender date]; // 获取被选中的时间
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = self.dateFormat; // 设置时间和日期的格式
    self.timeString = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
}

- (void)actionHide:(UIButton*)btn
{
    if (btn.tag == 0) {
        [self hide];
    } else {
        self.inputHandler(self.timeString);
        [self hide];
    }
    
}

@end
