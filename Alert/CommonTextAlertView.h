//
//  CommonTextAlertView.h
//  BeijingHyundai
//
//  Created by djw on 2017/4/19.
//  Copyright © 2017年 ubiquitous. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, TextAlertActionStyle) {
    TextAlertActionStyleDefault = 0,
    TextAlertActionStyleDestructive,
    TextAlertActionStyleCustom,
};

@interface CommonTextAlertView : UIView

/**
 自定义 textView 的 alert

 @param message  标题
 @param placeholder 占位文字
 @param okTitle 确定按钮文字
 @param okStyle 确定按钮样式
 @param cancelTitle 取消按钮文字
 @param cancelStyle 取消按钮样式
 @param okHandler 确定回调
 @param cancelHandler 取消回调
 */
- (instancetype)initWithMessage:(NSString *)message
                    placeholder:(NSString *)placeholder
                       okAction:(NSString *)okTitle
                  okActionStyle:(TextAlertActionStyle)okStyle
                   cancelAction:(NSString *)cancelTitle
              cancelActionStyle:(TextAlertActionStyle)cancelStyle
                      okHandler:(void(^)(NSString *alertString))okHandler
                  cancelHandler:(void(^)(void))cancelHandler;

@end
