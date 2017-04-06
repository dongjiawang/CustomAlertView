//
//  CustomAlertView.m
//  BeijingHyundai
//
//  Created by djw on 2017/4/6.
//  Copyright © 2017年 ubiquitous. All rights reserved.
//

#import "CustomAlertView.h"

@interface CustomAlertView ()

@property (nonatomic, strong) UIView    *backGroudView;

@property (nonatomic, strong) UIView    *diogView;

@property (nonatomic, strong) UILabel   *titleLabel;

@property (nonatomic, strong) UILabel   *contentLabel;

@property (nonatomic, strong) UIButton  *confirBtn;

@property (nonatomic, strong) UIButton  *cancelBtn;

@end

@implementation CustomAlertView

- (instancetype)initWithMessage:(NSString *)message
                 confirBtnTitle:(NSString *)confirBtnTitle
                 cancelBtnTitle:(NSString *)cancelBtnTitle
                     buttonType:(int)buttonType
                withTapGuesture:(BOOL)tapGuesture {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.backGroudView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.height.equalTo(self);
            make.center.equalTo(self);
        }];
        
        CGRect messageSize = [message boundingRectWithSize:CGSizeMake((200 + RUNNING_SCREEN_DIFF_WIDTH), 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont customFontSize:15.0]} context:nil];
        
        [self.diogView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200+RUNNING_SCREEN_DIFF_WIDTH);
            make.height.mas_equalTo(messageSize.size.height + 100);
            make.center.equalTo(self);
        }];
        
        self.contentLabel.text = message;
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(messageSize.size.height + 5);
        }];
        
        [self addButton:buttonType];
        
        if (tapGuesture) {
            [self addTapGesture];
        }
    }
    return self;
}

- (void)addButton:(int)type {
    switch (type) {
        case 1: //1个短按钮
        {
            [self.confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-10);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(30);
                make.centerX.equalTo(_diogView.mas_centerX);
            }];
        }
            break;
        case 2://上下2个长按钮
        {
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-10);
                make.width.mas_equalTo(160);
                make.height.mas_equalTo(30);
                make.centerX.equalTo(_diogView.mas_centerX);
            }];
            
            [self.confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_cancelBtn.mas_top).offset(-10);
                make.width.equalTo(_cancelBtn);
                make.height.equalTo(_cancelBtn);
                make.centerX.equalTo(_cancelBtn);
            }];
            
            CGRect messageSize = [self.contentLabel.text boundingRectWithSize:CGSizeMake((200 + RUNNING_SCREEN_DIFF_WIDTH), 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont customFontSize:15.0]} context:nil];
            
            [self.diogView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(messageSize.size.height + 140);
            }];
        }
            break;
        case 3: //并行2个按钮
        {
            [self.confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-10);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(100);
                make.left.mas_equalTo(10);
            }];
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-10);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(100);
                make.right.mas_equalTo(-10);
            }];
            
        }
            break;
        case 4:
        {
            self.confirBtn.backgroundColor = [UIColor lightGrayColor];
            self.cancelBtn.backgroundColor = [UIColor navgationBarTintColor];
            [self.confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(10);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(80);
                make.left.mas_equalTo(20);
            }];
            [self.confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(10);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(80);
                make.right.mas_equalTo(20);
            }];
        }
            break;
            
        default:
            break;
    }
}

- (UIView *)backGroudView {
    if (!_backGroudView) {
        _backGroudView = [[UIView alloc] init];
        _backGroudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self addSubview:_backGroudView];
    }
    return _backGroudView;
}

- (UIView *)diogView {
    if (!_diogView) {
        _diogView = [[UIView alloc] init];
        _diogView.backgroundColor = [UIColor whiteColor];
        _diogView.layer.cornerRadius = 15;
        [self addSubview:_diogView];
    }
    return _diogView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont customFontSize:15.0];
        _titleLabel.text = @"温馨提示";
        _titleLabel.textColor = [UIColor darkGrayColor];
        [_diogView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont customFontSize:15.0];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        [_diogView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIButton *)confirBtn {
    if (!_confirBtn) {
        _confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirBtn.layer.cornerRadius = 3;
        [_confirBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirBtn.titleLabel.font = [UIFont customFontSize:15.0];
        _confirBtn.backgroundColor = [UIColor navgationBarTintColor];
        [_diogView addSubview:_confirBtn];
        [_confirBtn addTarget:self action:@selector(didClickedConfirButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = [UIColor lightGrayColor];
        _cancelBtn.layer.cornerRadius = 3;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont customFontSize:15.0];
        _cancelBtn.backgroundColor = [UIColor lightGrayColor];
        [_diogView addSubview:_cancelBtn];
        [_cancelBtn addTarget:self action:@selector(didClickedCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBackView)];
    tap.numberOfTouchesRequired = 1; //手指数
    tap.numberOfTapsRequired = 1; //tap次数
    [self addGestureRecognizer:tap];
}

- (void)tapOnBackView {
    [self removeFromSuperview];
}

- (void)didClickedConfirButton {
    [self removeFromSuperview];
    if (_clickedConfirBtn) {
        self.clickedConfirBtn();
    }
}

- (void)didClickedCancelButton {
    [self removeFromSuperview];
    if (_clickedCancelBtn) {
        self.clickedCancelBtn();
    }
}


@end
