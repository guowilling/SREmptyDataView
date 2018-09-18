//
//  UIView+SRFrame.m
//  SREmptyDataViewDemo
//
//  Created by https://github.com/guowilling on 2018/1/11.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "UIView+SRFrame.h"

@implementation UIView (SRFrame)

#pragma mark - x, y, width, height

- (CGFloat)sr_x {
    return self.frame.origin.x;
}

- (void)setSr_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)sr_y {
    return self.frame.origin.y;
}

- (void)setSr_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)sr_width {
    return self.frame.size.width;
}

- (void)setSr_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)sr_height {
    return self.frame.size.height;
}

- (void)setSr_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - origin, size, center

- (CGPoint)sr_origin {
    return self.frame.origin;
}

- (void)setSr_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)sr_size {
    return self.frame.size;
}

- (void)setSr_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)sr_centerX {
    return self.center.x;
}

- (void)setSr_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)sr_centerY {
    return self.center.y;
}

- (void)setSr_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

#pragma mark - top, left, bottom, right

- (CGFloat)sr_top {
    return self.sr_y;
}

- (void)setSr_top:(CGFloat)sr_top {
    [self setSr_y:sr_top];
}

- (CGFloat)sr_left {
    return self.sr_x;
}

- (void)setSr_left:(CGFloat)sr_left {
    [self setSr_x:sr_left];
}

- (CGFloat)sr_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setSr_bottom:(CGFloat)sr_bottom {
    [self setSr_y:(sr_bottom - self.sr_height)];
}

- (CGFloat)sr_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setSr_right:(CGFloat)sr_right {
    [self setSr_x:(sr_right - self.sr_width)];
}

@end
