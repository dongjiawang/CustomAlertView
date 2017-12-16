//
//  CommonTextAlertView.m
//  BeijingHyundai
//
//  Created by djw on 2017/4/19.
//  Copyright © 2017年 ubiquitous. All rights reserved.
//

#import "CommonTextAlertView.h"

typedef NS_OPTIONS(NSUInteger, ActionType) {
    ActionTypeOK = 0,
    ActionTypeCancel,
};

@interface CommonTextAlertView ()<UITextViewDelegate>

@property (nonatomic,strong) UIView *diogBGView;

@property (nonatomic,strong) UILabel *messageLabel;

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic, copy) void(^clickedOkAction)(NSString *string);
@property (nonatomic, copy) void(^clickedCancel)(void);

@end

@implementation CommonTextAlertView

- (instancetype)initWithMessage:(NSString *)message
                    placeholder:(NSString *)placeholder
                       okAction:(NSString *)okTitle
                  okActionStyle:(TextAlertActionStyle)okStyle
                   cancelAction:(NSString *)cancelTitle
              cancelActionStyle:(TextAlertActionStyle)cancelStyle
                      okHandler:(void (^)(NSString *))okHandler
                  cancelHandler:(void (^)(void))cancelHandler {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        
        [self initDiogBGView];
        
         CGFloat diogBGView_H = [self initMessageLabelWithMessage:message];
        diogBGView_H = [self initTextViewWithFrameY:diogBGView_H placeholder:placeholder];
        
        [self initActionWithTitle:okTitle type:ActionTypeOK style:okStyle antionY:diogBGView_H];
        
        diogBGView_H = [self initActionWithTitle:cancelTitle type:ActionTypeCancel style:cancelStyle antionY:diogBGView_H];
        
        _diogBGView.frame = CGRectMake(0, 200, _diogBGView.frame.size.width, diogBGView_H);
        CGPoint center = _diogBGView.center;
        center.y = self.center.y - 80;
        center.x = self.center.x;
        _diogBGView.center = center;
        
        
        self.clickedOkAction = ^(NSString *string) {
            if (okHandler) {
                okHandler(string);
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

- (CGFloat)initActionWithTitle:(NSString *)title type:(ActionType)type style:(TextAlertActionStyle)style antionY:(CGFloat)action_Y {
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
    
    if (style == TextAlertActionStyleDefault) {
        [actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else if (style == TextAlertActionStyleDestructive) {
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

- (CGFloat)initTextViewWithFrameY:(CGFloat)textView_Y placeholder:(NSString *)placeholder {
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, textView_Y, _diogBGView.bounds.size.width, 80)];
    _textView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    _textView.font = [UIFont systemFontOfSize:14.0];
    [_textView becomeFirstResponder];
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholder;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.0];
    [placeHolderLabel sizeToFit];
    [_textView addSubview:placeHolderLabel];
    [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    [_diogBGView addSubview:_textView];
    
    return textView_Y + _textView.frame.size.height;
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

- (void)didClickedAction:(UIButton *)sender {
    if (sender.tag == ActionTypeOK) {
        if (_clickedOkAction) {
            self.clickedOkAction(_textView.text);
            [self removeTextAlertView];
        }
    }
    else {
        if (_clickedCancel) {
            self.clickedCancel();
        }
        [self removeTextAlertView];
    }
}

- (void)removeTextAlertView {
    [self removeFromSuperview];
}

@end
