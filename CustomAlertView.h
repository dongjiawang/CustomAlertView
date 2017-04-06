//
//  CustomAlertView.h
//  BeijingHyundai
//
//  Created by djw on 2017/4/6.
//  Copyright © 2017年 ubiquitous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView
/**
 创建自定义提示框
 
 @param message 提示信息
 @param confirBtnTitle 确认按钮文字
 @param cancelBtnTitle 取消按钮文字
 @param buttonType 按钮样式
 @param tapGuesture 是否空白处移除
 @return 提示框
 */
- (instancetype)initWithMessage:(NSString *)message
                 confirBtnTitle:(NSString *)confirBtnTitle
                 cancelBtnTitle:(NSString *)cancelBtnTitle
                     buttonType:(int)buttonType
                withTapGuesture:(BOOL)tapGuesture;

@property (nonatomic, copy) void(^clickedConfirBtn)();

@property (nonatomic, copy) void(^clickedCancelBtn)();

@end
