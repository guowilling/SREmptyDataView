//
//  SREmptyDataBaseView.h
//  SREmptyDataViewDemo
//
//  Created by https://github.com/guowilling on 2018/1/11.
//  Copyright © 2018年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SRTapBlock)(void);

@interface SREmptyDataBaseView : UIView

/**
 是否自动推断显示还是隐藏占位视图.
 */
@property (nonatomic, assign) BOOL autoManagement;

@property (nonatomic, copy  ) SRTapBlock tapBlock;
@property (nonatomic, copy  ) SRTapBlock btnBlock;

@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UIView *customView;

@property (nonatomic, copy  , readonly) NSString *icon;
@property (nonatomic, copy  , readonly) NSString *title;
@property (nonatomic, copy  , readonly) NSString *detail;
@property (nonatomic, copy  , readonly) NSString *btnTitle;

/**
 通过配置参数, 快速创建一个列表无数据时的占位视图.
 如果传递的参数为 nil, 则不会创建相应控件.

 @param icon     提示图标.
 @param title    提示标题.
 @param detail   提示描述.
 @param btnTitle 重试按钮标题.
 @param btnBlock 重试按钮回调 Block.
 @return 占位视图.
 */
+ (instancetype)sr_emptyDataViewWithIcon:(NSString *)icon title:(NSString *)title detail:(NSString *)detail btnTitle:(NSString *)btnTitle btnBlock:(SRTapBlock)btnBlock;

/**
 通过自定义的视图, 快速创建一个列表无数据时的占位视图.

 @param customView 自定义视图.
 @return 占位视图.
 */
+ (instancetype)sr_emptyDataViewWithCustomView:(UIView *)customView;

/**
 用于子类重写自定义 UI 属性.
 */
- (void)prepare;

- (void)setupSubviews;

@end
