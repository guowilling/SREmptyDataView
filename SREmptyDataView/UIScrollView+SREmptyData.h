//
//  UIScrollView+SREmptyData.h
//  SREmptyDataViewDemo
//
//  Created by https://github.com/guowilling on 2018/1/11.
//  Copyright © 2018年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SREmptyDataView;

@interface UIScrollView (SREmptyData)

/**
 列表无数据时的占位视图.
 */
@property (nonatomic, strong) SREmptyDataView *sr_emptyDataView;

/**
 用于加载列表数据之前调用, 避免因为没有数据造成的自动显示占位视图.
 */
- (void)sr_startLoadingData;

/**
 用于加载数据完成, 刷新列表之后调用, 自动推断是否显示占位视图.
 */
- (void)sr_endLoadingData;

/**
 通过此方法强行显示占位视图.
 */
- (void)sr_showEmptyDataView;

/**
 通过此方法强行隐藏占位视图.
 */
- (void)sr_hideEmptyDataView;

@end
