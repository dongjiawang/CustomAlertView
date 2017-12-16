//
//  StarTextAlertView.h
//  myTest
//
//  Created by 董佳旺 on 2017/12/14.
//  Copyright © 2017年 董佳旺. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, StarTextAlertActionStyle) {
    StarTextAlertActionStyleDefault = 0,
    StarTextAlertActionStyleDestructive,
    StarTextAlertActionStyleCustom,
};

@interface StarTextAlertView : UIView

/**
 自定义星级评论框

 @param placeholder 占位文字
 @param okTitle 确定按钮文字
 @param okStyle 确定按钮样式
 @param cancelTitle 取消按钮文字
 @param cancelStyle 取消按钮样式
 @param okHandler 确定按钮回调
 @param cancelHandler 取消按钮回调
 */
- (instancetype)initWithPlaceholder:(NSString *)placeholder
                           okAction:(NSString *)okTitle
                      okActionStyle:(StarTextAlertActionStyle)okStyle
                       cancelAction:(NSString *)cancelTitle
                  cancelActionStyle:(StarTextAlertActionStyle)cancelStyle
                          okHandler:(void(^)(CGFloat starValue, NSString *alertString))okHandler
                             cancel:(void(^)(void))cancelHandler;

@end
