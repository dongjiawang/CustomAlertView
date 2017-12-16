//
//  StarAlertView.h
//  myTest
//
//  Created by 董佳旺 on 2017/12/13.
//  Copyright © 2017年 董佳旺. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, StarAlertActionStyle) {
    StarAlertActionStyleDefault = 0,
    StarAlertActionStyleDestructive,
    StarAlertActionStyleCustom,
};

@interface StarAlertView : UIView

/**
 自定义星级 alert

 @param message 标题文字
 @param value 星星数值
 @param okTitle 确定按钮文字
 @param okStyle 确定按钮样式
 @param cancelTitle 取消按钮文字
 @param cancelStyle 取消按钮样式
 @param okHandler 确定回调
 @param cancelHandler 取消回调
 */
- (instancetype)initWithMessage:(NSString *)message
                      StarValue:(CGFloat)value
                       okAction:(NSString *)okTitle
                  okActionStyle:(StarAlertActionStyle)okStyle
                   cancelAction:(NSString *)cancelTitle
              cancelActionStyle:(StarAlertActionStyle)cancelStyle
                      okHandler:(void(^)(CGFloat starValue))okHandler
                  cancelHandler:(void(^)(void))cancelHandler;

@end
