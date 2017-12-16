//
//  StarTextAlertView.m
//  myTest
//
//  Created by 董佳旺 on 2017/12/14.
//  Copyright © 2017年 董佳旺. All rights reserved.
//

#import "StarTextAlertView.h"
#import "HCSStarRatingView.h"

typedef NS_OPTIONS(NSUInteger, ActionType) {
    ActionTypeOK = 0,
    ActionTypeCancel,
};

@interface StarTextAlertView ()

@property (nonatomic,strong) UIView *diogBGView;

@property (nonatomic,strong) HCSStarRatingView *starView;

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic, copy) void(^clickedOkAction)(CGFloat starValue, NSString *text);

@property (nonatomic, copy) void(^clickedCancel)(void);

@end

@implementation StarTextAlertView

- (instancetype)initWithPlaceholder:(NSString *)placeholder
                           okAction:(NSString *)okTitle
                      okActionStyle:(StarTextAlertActionStyle)okStyle
                       cancelAction:(NSString *)cancelTitle
                  cancelActionStyle:(StarTextAlertActionStyle)cancelStyle
                          okHandler:(void (^)(CGFloat, NSString *))okHandler
                             cancel:(void (^)(void))cancelHandler {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        
        [self initDiogBGView];
        
        CGFloat diogBGView_H = [self initStarView];
        
        diogBGView_H = [self initTextViewWithFrameY:diogBGView_H placeholder:placeholder];
        
        // 创建确定按钮
        [self initActionWithTitle:okTitle type:ActionTypeOK style:okStyle antionY:diogBGView_H];
        // 创建取消按钮
        diogBGView_H = [self initActionWithTitle:cancelTitle type:ActionTypeCancel style:cancelStyle antionY:diogBGView_H];
        
        _diogBGView.frame = CGRectMake(0, 200, _diogBGView.frame.size.width, diogBGView_H);
        CGPoint center = _diogBGView.center;
        center.y = self.center.y - 80;
        center.x = self.center.x;
        _diogBGView.center = center;
        
        self.clickedOkAction = ^(CGFloat starValue, NSString *text) {
            if (okHandler) {
                okHandler(starValue, text);
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

- (CGFloat)initStarView {
    _starView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(50, 20, _diogBGView.bounds.size.width - 100, 25)];
    
    _starView.backgroundColor = [UIColor clearColor];
    _starView.maximumValue = 5;
    _starView.minimumValue = 0;
    _starView.allowsHalfStars = YES;
    _starView.emptyStarImage = [UIImage imageNamed:@"evaluateStar_empty.png"];
    _starView.filledStarImage = [UIImage imageNamed:@"evaluateStar_fill.png"];
    _starView.halfStarImage = [UIImage imageNamed:@"evaluateStar_half.png"];
    _starView.spacing = 3;
    [self.diogBGView addSubview:_starView];
    
    return _starView.frame.origin.y + _starView.frame.size.height + 20;
}

- (CGFloat)initTextViewWithFrameY:(CGFloat)textView_Y placeholder:(NSString *)placeholder {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, textView_Y, _diogBGView.bounds.size.width, 80)];
    _textView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    _textView.font = [UIFont systemFontOfSize:14.0];
    [_textView becomeFirstResponder];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = [NSString stringWithFormat:@"  %@", placeholder];
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.0];
    [placeHolderLabel sizeToFit];
    [_textView addSubview:placeHolderLabel];
    [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    [_diogBGView addSubview:_textView];
    
    return textView_Y + _textView.frame.size.height;
}

- (CGFloat)initActionWithTitle:(NSString *)title type:(ActionType)type style:(StarTextAlertActionStyle)style antionY:(CGFloat)action_Y {
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
    
    if (style == StarTextAlertActionStyleDefault) {
        [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (style == StarTextAlertActionStyleDestructive) {
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
            self.clickedOkAction(_starView.value, _textView.text);
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
