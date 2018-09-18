//
//  SREmptyDataBaseView.m
//  SREmptyDataViewDemo
//
//  Created by https://github.com/guowilling on 2018/1/11.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "SREmptyDataBaseView.h"
#import "UIView+SRFrame.h"

@interface SREmptyDataBaseView ()

@property (nonatomic, strong, readwrite) UIView *contentView;
@property (nonatomic, strong, readwrite) UIView *customView;

@end

@implementation SREmptyDataBaseView

+ (instancetype)sr_emptyDataViewWithIcon:(NSString *)icon title:(NSString *)title detail:(NSString *)detail btnTitle:(NSString *)btnTitle btnBlock:(SRTapBlock)btnBlock {
    return [[self alloc] initWithIcon:icon title:title detail:detail btnTitle:btnTitle btnBlock:btnBlock];
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title detail:(NSString *)detail btnTitle:(NSString *)btnTitle btnBlock:(SRTapBlock)btnBlock {
    if (self = [self init]) {
        _icon = icon;
        _title = title;
        _detail = detail;
        _btnTitle = btnTitle;
        _btnBlock = btnBlock;
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentView)];
        [_contentView addGestureRecognizer:tap];
        [self addSubview:_contentView];
    }
    return self;
}

+ (instancetype)sr_emptyDataViewWithCustomView:(UIView *)customView {
    return [[self alloc] initWithCustomView:customView];
}

- (instancetype)initViewWithCustomView:(UIView *)customView {
    if (self = [self init]) {
        _customView = customView;
        
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContentView)];
        [_contentView addGestureRecognizer:tap];
        [_contentView addSubview:customView];
        
        [self addSubview:_contentView];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.autoManagement = YES;
        [self prepare];
    }
    return self;
}

- (void)prepare {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIView *superview = self.superview;
    if (superview && [superview isKindOfClass:[UIScrollView class]]) {
        self.sr_width = superview.sr_width;
        self.sr_height = superview.sr_height;
    }
    
    [self setupSubviews];
}

- (void)setupSubviews {
    // 子类重写
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        self.sr_width = newSuperview.sr_width;
        self.sr_height = newSuperview.sr_height;
    }
}

- (void)tapContentView {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

@end
