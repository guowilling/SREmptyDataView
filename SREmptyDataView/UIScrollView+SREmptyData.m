//
//  UIScrollView+SREmptyData.m
//  SREmptyDataViewDemo
//
//  Created by https://github.com/guowilling on 2018/1/11.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "UIScrollView+SREmptyData.h"
#import "SREmptyDataView.h"
#import <objc/runtime.h>

@implementation UIScrollView (SREmptyData)

- (void)setSr_emptyDataView:(SREmptyDataView *)sr_emptyDataView {
    objc_setAssociatedObject(self, @selector(sr_emptyDataView), sr_emptyDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // remove old sr_emptyDataView if exist
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[SREmptyDataView class]]) {
            [view removeFromSuperview];
        }
    }
    [self addSubview:sr_emptyDataView];
}

- (SREmptyDataView *)sr_emptyDataView {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - Private Methods

- (void)showOrHideEmptyView {
    if (self.sr_emptyDataView.autoManagement) {
        if ([self shouldShowEmptyView]) {
            [self sr_showEmptyDataView];
        } else {
            [self sr_hideEmptyDataView];
        }
    }
}

- (BOOL)shouldShowEmptyView {
    NSInteger dataCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            dataCount += [tableView numberOfRowsInSection:section];
        }
    }
    if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            dataCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return dataCount == 0;
}

#pragma mark - Public Methods

- (void)sr_showEmptyDataView {
    self.sr_emptyDataView.hidden = NO;
    
    [self.sr_emptyDataView.superview setNeedsLayout];
    [self.sr_emptyDataView.superview layoutIfNeeded];
    
    [self bringSubviewToFront:self.sr_emptyDataView];
}

- (void)sr_hideEmptyDataView {
    self.sr_emptyDataView.hidden = YES;
}

- (void)sr_startLoadingData {
    [self sr_hideEmptyDataView];
}

- (void)sr_endLoadingData {
    if ([self shouldShowEmptyView]) {
        [self sr_showEmptyDataView];
    }
}

@end

@implementation UITableView (SREmptyDataView)

+ (void)load {
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method sr_reloadData = class_getInstanceMethod(self, @selector(sr_reloadData));
    method_exchangeImplementations(reloadData, sr_reloadData);
    
    Method insertSections = class_getInstanceMethod(self, @selector(insertSections:withRowAnimation:));
    Method sr_insertSections = class_getInstanceMethod(self, @selector(sr_insertSections:withRowAnimation:));
    method_exchangeImplementations(insertSections, sr_insertSections);
    
    Method deleteSections = class_getInstanceMethod(self, @selector(deleteSections:withRowAnimation:));
    Method sr_deleteSections = class_getInstanceMethod(self, @selector(sr_deleteSections:withRowAnimation:));
    method_exchangeImplementations(deleteSections, sr_deleteSections);
    
    Method insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(insertRowsAtIndexPaths:withRowAnimation:));
    Method sr_insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(sr_insertRowsAtIndexPaths:withRowAnimation:));
    method_exchangeImplementations(insertRowsAtIndexPaths, sr_insertRowsAtIndexPaths);
    
    Method deleteRowsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteRowsAtIndexPaths:withRowAnimation:));
    Method sr_deleteRowsAtIndexPaths = class_getInstanceMethod(self, @selector(sr_deleteRowsAtIndexPaths:withRowAnimation:));
    method_exchangeImplementations(deleteRowsAtIndexPaths, sr_deleteRowsAtIndexPaths);
}

- (void)sr_reloadData {
    [self sr_reloadData];
    [self showOrHideEmptyView];
}

- (void)sr_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self sr_insertSections:sections withRowAnimation:animation];
    [self showOrHideEmptyView];
}

- (void)sr_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self sr_insertSections:sections withRowAnimation:animation];
    [self showOrHideEmptyView];
}

- (void)sr_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self sr_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showOrHideEmptyView];
}

- (void)sr_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self sr_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showOrHideEmptyView];
}

@end

@implementation UICollectionView (SREmptyDataView)

+ (void)load {
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method sr_reloadData = class_getInstanceMethod(self, @selector(sr_reloadData));
    method_exchangeImplementations(reloadData, sr_reloadData);
    
    Method insertSections = class_getInstanceMethod(self, @selector(insertSections:));
    Method sr_insertSections = class_getInstanceMethod(self, @selector(sr_insertSections:));
    method_exchangeImplementations(insertSections, sr_insertSections);
    
    Method deleteSections = class_getInstanceMethod(self, @selector(deleteSections:));
    Method sr_deleteSections = class_getInstanceMethod(self, @selector(sr_deleteSections:));
    method_exchangeImplementations(deleteSections, sr_deleteSections);
    
    Method insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(insertItemsAtIndexPaths:));
    Method sr_insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(sr_insertItemsAtIndexPaths:));
    method_exchangeImplementations(insertItemsAtIndexPaths, sr_insertItemsAtIndexPaths);
    
    Method deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteItemsAtIndexPaths:));
    Method sr_deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(sr_deleteItemsAtIndexPaths:));
    method_exchangeImplementations(deleteItemsAtIndexPaths, sr_deleteItemsAtIndexPaths);
}

- (void)sr_reloadData {
    [self sr_reloadData];
    [self showOrHideEmptyView];
}

- (void)sr_insertSections:(NSIndexSet *)sections {
    [self sr_insertSections:sections];
    [self showOrHideEmptyView];
}

- (void)sr_deleteSections:(NSIndexSet *)sections {
    [self sr_deleteSections:sections];
    [self showOrHideEmptyView];
}

- (void)sr_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self sr_insertItemsAtIndexPaths:indexPaths];
    [self showOrHideEmptyView];
}

- (void)sr_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self sr_deleteItemsAtIndexPaths:indexPaths];
    [self showOrHideEmptyView];
}

@end
