//
//  StarAlertView.m
//  myTest
//
//  Created by 董佳旺 on 2017/12/13.
//  Copyright © 2017年 董佳旺. All rights reserved.
//

#import "StarAlertView.h"
#import "HCSStarRatingView.h"


typedef NS_OPTIONS(NSUInteger, ActionType) {
    ActionTypeOK = 0,
    ActionTypeCancel,
};

@interface StarAlertView ()

@property (nonatomic,strong) UIView *diogBGView;

@property (nonatomic,strong) HCSStarRatingView *starView;

@property (nonatomic,strong) UILabel *valueLabel;

@property (nonatomic, copy) void(^clickedOkAction)(CGFloat starValue);

@property (nonatomic, copy) void(^clickedCancel)(void);

@end

@implementation StarAlertView

- (instancetype)initWithMessage:(NSString *)message
                      StarValue:(CGFloat)value
                       okAction:(NSString *)okTitle
                  okActionStyle:(StarAlertActionStyle)okStyle
                   cancelAction:(NSString *)cancelTitle
              cancelActionStyle:(StarAlertActionStyle)cancelStyle
                      okHandler:(void (^)(CGFloat))okHandler
                  cancelHandler:(void (^)(void))cancelHandler {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        
        [self initDiogBGView];
        // 创建标题
        CGFloat diogBGView_H = [self initMessageLabelWithMessage:message];
        // 创建星级框
        diogBGView_H = [self initStarViewWithFrameY:diogBGView_H];
        // 分数数值显示
        diogBGView_H = [self initValueLabelWithFrameY:diogBGView_H];
        // 创建确定按钮
        [self initActionWithTitle:okTitle type:ActionTypeOK style:okStyle antionY:diogBGView_H];
        // 创建取消按钮
         diogBGView_H = [self initActionWithTitle:cancelTitle type:ActionTypeCancel style:cancelStyle antionY:diogBGView_H];
        
        _diogBGView.frame = CGRectMake(0, 200, _diogBGView.frame.size.width, diogBGView_H);
        CGPoint center = _diogBGView.center;
        center.y = self.center.y - 80;
        center.x = self.center.x;
        _diogBGView.center = center;
        
        _starView.value = value;
        
        self.clickedOkAction = ^(CGFloat starValue) {
            if (okHandler) {
                okHandler(starValue);
            }
        };
        
        self.clickedCancel = ^{
            if (cancelHandler) {
                cancelHandler();
            }
        };
    }
    return self;
}

- (void)initDiogBGView {
    self.diogBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.bounds.size.width - 100, self.bounds.size.height)];
    self.diogBGView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.99];
    self.diogBGView.layer.cornerRadius = 15.0;
    [self addSubview:self.diogBGView];
}

- (CGFloat)initMessageLabelWithMessage:(NSString *)message {
    CGRect messageSize = [message boundingRectWithSize:CGSizeMake(_diogBGView.bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil];
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, _diogBGView.bounds.size.width - 20, messageSize.size.height+5)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.font = [UIFont boldSystemFontOfSize:16.0];
    messageLabel.text = message;
    [_diogBGView addSubview:messageLabel];
    
    return messageLabel.frame.size.height + messageLabel.frame.origin.y + 10;
}

- (CGFloat)initStarViewWithFrameY:(CGFloat)starViewY {
    _starView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, starViewY, _diogBGView.bounds.size.width - 100, 25)];
    
    _starView.backgroundColor = [UIColor clearColor];
    _starView.maximumValue = 5;
    _starView.minimumValue = 0;
    _starView.allowsHalfStars = YES;
    _starView.emptyStarImage = [UIImage imageNamed:@"evaluateStar_empty.png"];
    _starView.filledStarImage = [UIImage imageNamed:@"evaluateStar_fill.png"];
    _starView.halfStarImage = [UIImage imageNamed:@"evaluateStar_half.png"];
    _starView.spacing = 3;
    [self.diogBGView addSubview:_starView];
    
    __weak typeof(self) weakSelf = self;
    _starView.getStarValue = ^(float value) {
        weakSelf.valueLabel.text = [NSString stringWithFormat:@"%.0f 分", value * 20];
    };
    
    return starViewY + _starView.frame.size.height;
}

- (CGFloat)initValueLabelWithFrameY:(CGFloat)frameY {
    _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, frameY + 10, _starView.frame.size.width, 30)];
    _valueLabel.textColor = [UIColor grayColor];
    _valueLabel.font = [UIFont systemFontOfSize:16.0];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.text = @"0 分";
    [self.diogBGView addSubview:_valueLabel];
    
    return frameY + _valueLabel.frame.size.height;
}


- (CGFloat)initActionWithTitle:(NSString *)title type:(ActionType)type style:(StarAlertActionStyle)style antionY:(CGFloat)action_Y {
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    actionBtn.layer.cornerRadius = 3;
    CGFloat btnW = 80 + ([UIScreen mainScreen].bounds.size.width - 320) / 4;
    if (type == ActionTypeCancel) {
        actionBtn.frame = CGRectMake(10, action_Y+12, btnW, 30);
    }
    else {
        actionBtn.frame = CGRectMake(_diogBGView.bounds.size.width - 10 - 100, action_Y+12, btnW, 30);
    }
    [actionBtn setTitle:title forState:UIControlStateNormal];
    actionBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    if (style == StarAlertActionStyleDefault) {
        [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (style == StarAlertActionStyleDestructive) {
        [actionBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else {
        if (type == ActionTypeCancel) {
            [actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            actionBtn.backgroundColor = [UIColor redColor];
        }
        else {
            [actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            actionBtn.backgroundColor = [UIColor lightGrayColor];
        }
    }
    
    actionBtn.adjustsImageWhenHighlighted = NO;
    actionBtn.tag = type;
    [_diogBGView addSubview:actionBtn];
    [actionBtn addTarget:self action:@selector(didClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return actionBtn.frame.size.height + action_Y + 22;
}

- (void)didClickedAction:(UIButton *)sender {
    if (sender.tag == ActionTypeOK) {
        if (_clickedOkAction) {
            self.clickedOkAction(_starView.value);
            [self removeStarAlertView];
        }
    }
    else {
        if (_clickedCancel) {
            self.clickedCancel();
        }
        [self removeStarAlertView];
    }
}

- (void)removeStarAlertView {
    [self removeFromSuperview];
}


@end
