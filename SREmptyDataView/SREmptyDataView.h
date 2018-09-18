//
//  SREmptyDataView.h
//  SREmptyDataViewDemo
//
//  Created by https://github.com/guowilling on 2018/1/11.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "SREmptyDataBaseView.h"

@interface SREmptyDataView : SREmptyDataBaseView

@property (nonatomic, assign) CGFloat contentViewOffsetY;
@property (nonatomic, assign) CGFloat subviewMargin;
@property (nonatomic, assign) CGFloat actionBtnHorizontalEdge;
@property (nonatomic, assign) CGFloat actionBtnCornerRadius;
@property (nonatomic, assign) CGFloat actionBtnBorderWidth;
@property (nonatomic, assign) CGFloat actionBtnHeight;
@property (nonatomic, assign) CGSize  iconSize;

@property (nonatomic, strong) UIFont  *titleFont;
@property (nonatomic, strong) UIFont  *detailFont;
@property (nonatomic, strong) UIFont  *actionBtnTitleFont;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *detailColor;
@property (nonatomic, strong) UIColor *actionBtnTitleColor;
@property (nonatomic, strong) UIColor *actionBtnBackgroundColor;
@property (nonatomic, strong) UIColor *actionBtnBorderColor;

@end
