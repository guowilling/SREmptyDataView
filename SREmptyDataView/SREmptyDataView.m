//
//  SREmptyDataView.m
//  SREmptyDataViewDemo
//
//  Created by https://github.com/guowilling on 2018/1/11.
//  Copyright © 2018年 SR. All rights reserved.
//

#import "SREmptyDataView.h"
#import "UIView+SRFrame.h"

#define kSubviewMargin 20.f

#define kTitleFont [UIFont systemFontOfSize:16.f]

#define kDetailFont [UIFont systemFontOfSize:14.f]

#define kActionBtnTitleFont [UIFont systemFontOfSize:14.f]

#define kActionBtnHeight 40.f

#define kActionBtnHorizontalEdge 30.f

#define kBlackColor [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:1.f]
#define kGrayColor  [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.f]

@interface SREmptyDataView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailLabel;
@property (nonatomic, strong) UIButton    *actionBtn;

@property (nonatomic, assign) CGFloat contentMaxWidth;
@property (nonatomic, assign) CGFloat contentW;
@property (nonatomic, assign) CGFloat contentH;

@end

@implementation SREmptyDataView

#pragma mark - Lazy Load

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UIButton *)actionBtn {
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc] init];
        _actionBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:_actionBtn];
    }
    return _actionBtn;
}

#pragma mark - Override

- (void)prepare {
    [super prepare];
    
    // custom UI style here
}

- (void)setupSubviews {
    [super setupSubviews];
    
    _subviewMargin = self.subviewMargin ?: kSubviewMargin;
    self.contentMaxWidth = self.sr_width - 30.f;
    self.contentW = 0;
    self.contentH = 0;
    
    if (self.icon) {
        [self setupIconImageView:[UIImage imageNamed:self.icon]];
    }
    if (self.title) {
        [self setupTitleLabel:self.title];
    }
    if (self.detail) {
        [self setupDetailLabel:self.detail];
    }
    if (self.btnTitle && self.btnBlock) {
        [self setupBtn:self.btnTitle];
    }
    if (self.customView) {
        self.contentW = self.customView.sr_width;
        self.contentH = self.customView.sr_bottom;
    }
    
    [self setSubViewFrame];
}

- (void)setupIconImageView:(UIImage *)img {
    self.iconImageView.image = img;
    
    CGFloat imgViewW = img.size.width;
    CGFloat imgViewH = img.size.height;
    if (self.iconSize.width && self.iconSize.height) {
        if (imgViewW > imgViewH) {
            imgViewH = (imgViewH / imgViewW) * self.iconSize.width;
            imgViewW = self.iconSize.width;
        } else {
            imgViewW = (imgViewW / imgViewH) * self.iconSize.height;
            imgViewH = self.iconSize.height;
        }
    }
    self.iconImageView.frame = CGRectMake(0, 0, imgViewW, imgViewH);
    
    self.contentW = self.iconImageView.sr_width;
    self.contentH = self.iconImageView.sr_bottom;
}

- (void)setupTitleLabel:(NSString *)titleText {
    UIFont *font = self.titleFont ?: kTitleFont;
    CGFloat fontSize = font.pointSize;
    UIColor *textColor = self.titleColor ?: kBlackColor;
    CGFloat width = [self textSize:titleText size:CGSizeMake(self.contentMaxWidth, fontSize) font:font].width;
    self.titleLabel.frame = CGRectMake(0, self.contentH + self.subviewMargin, width, fontSize);
    self.titleLabel.text = titleText;
    self.titleLabel.textColor = textColor;
    self.titleLabel.font = font;
    
    self.contentW = width > self.contentW ? width : self.contentW;
    self.contentH = self.titleLabel.sr_bottom;
}

- (void)setupDetailLabel:(NSString *)detailText {
    UIFont *font = self.detailFont ?: kDetailFont;
    CGFloat fontSize = font.pointSize;
    UIColor *textColor = self.detailColor ?: kGrayColor;
    CGFloat maxHeight = 999 * (fontSize + 5);
    CGSize size = [self textSize:detailText size:CGSizeMake(self.contentMaxWidth, maxHeight) font:font];
    self.detailLabel.frame = CGRectMake(0, self.contentH + self.subviewMargin, size.width, size.height);
    self.detailLabel.text = detailText;
    self.detailLabel.textColor = textColor;
    self.detailLabel.font = font;
    
    self.contentW = size.width > self.contentW ? size.width : self.contentW;
    self.contentH = self.detailLabel.sr_bottom;
}

- (void)setupBtn:(NSString *)btnTitleText {
    UIFont *font = self.actionBtnTitleFont ?: kActionBtnTitleFont;
    CGFloat fontSize = font.pointSize;
    UIColor *titleColor = self.actionBtnTitleColor ?: kBlackColor;
    UIColor *backGColor = self.actionBtnBackgroundColor ?: [UIColor whiteColor];
    UIColor *borderColor = self.actionBtnBorderColor ?: [UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1];
    CGFloat borderWidth = self.actionBtnBorderWidth ?: 0.0f;
    CGFloat cornerRadius = self.actionBtnCornerRadius ?: 5.f;
    
    CGSize textSize = [self textSize:btnTitleText size:CGSizeMake(self.contentMaxWidth, fontSize) font:font];
    CGFloat btnHorizontalEdge = self.actionBtnHorizontalEdge ?: kActionBtnHorizontalEdge;
    CGFloat btnWidth = textSize.width + btnHorizontalEdge * 2;
    btnWidth = btnWidth > self.contentMaxWidth ? self.contentMaxWidth : btnWidth;
    CGFloat height = self.actionBtnHeight ?: kActionBtnHeight;
    if (height < textSize.height) {
        height = textSize.height + 5;
    }
    CGFloat btnHeight = height;
    self.actionBtn.frame = CGRectMake(0, self.contentH + self.subviewMargin, btnWidth, btnHeight);
    self.actionBtn.backgroundColor = backGColor;
    self.actionBtn.layer.borderColor = borderColor.CGColor;
    self.actionBtn.layer.borderWidth = borderWidth;
    self.actionBtn.layer.cornerRadius = cornerRadius;
    self.actionBtn.titleLabel.font = font;
    [self.actionBtn setTitle:btnTitleText forState:UIControlStateNormal];
    [self.actionBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [self.actionBtn addTarget:self action:@selector(actionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentW = btnWidth > self.contentW ? btnWidth : self.contentW;
    self.contentH = self.actionBtn.sr_bottom;
}

- (void)actionBtnAction:(UIButton *)sender {
    if (self.btnBlock) {
        self.btnBlock();
    }
}

- (CGSize)textSize:(NSString *)text size:(CGSize)size font:(UIFont *)font {
    return [text boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName: font}
                              context:nil].size;
}

- (void)setSubViewFrame {
    CGFloat scrollViewWidth = self.sr_width;
    CGFloat scrollViewHeight = self.sr_height;
    self.sr_size = CGSizeMake(self.contentW, self.contentH);
    self.center = CGPointMake(scrollViewWidth * 0.5f, scrollViewHeight * 0.5f);
    
    self.contentView.frame = self.bounds;
    
    CGFloat centerX = self.contentView.sr_width * 0.5f;
    if (self.customView) {
        self.customView.sr_centerX = centerX;
    } else {
        _iconImageView.sr_centerX = centerX;
        _titleLabel.sr_centerX = centerX;
        _detailLabel.sr_centerX = centerX;
        _actionBtn.sr_centerX = centerX;
    }
    
    if (self.contentViewOffsetY) {
        self.sr_centerY += self.contentViewOffsetY;
    }
}

#pragma mark - Settings

- (void)setContentViewOffsetY:(CGFloat)contentViewOffsetY {
    _contentViewOffsetY = contentViewOffsetY;
    
    self.sr_centerY = contentViewOffsetY;
}

- (void)setSubviewMargin:(CGFloat)subviewMargin {
    _subviewMargin = subviewMargin;
    
    [self setupSubviews];
}

- (void)setIconSize:(CGSize)iconSize {
    _iconSize = iconSize;
    
    if (_iconImageView) {
        [self setupSubviews];
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    if (_titleLabel) {
        [self setupSubviews];
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
        
    if (_titleLabel) {
        _titleLabel.textColor = titleColor;
    }
}

- (void)setDetailFont:(UIFont *)detailFont {
    _detailFont = detailFont;
    
    if (_detailLabel) {
        [self setupSubviews];
    }
}

- (void)setDetailLabColor:(UIColor *)detailColor {
    _detailColor = detailColor;
    
    if (_detailLabel) {
        _detailLabel.textColor = detailColor;
    }
}

- (void)setActionBtnTitleFont:(UIFont *)actionBtnTitleFont {
    _actionBtnTitleFont = actionBtnTitleFont;
    
    if (_actionBtn) {
        [self setupSubviews];
    }
}

- (void)setActionBtnHorizontalEdge:(CGFloat)actionBtnHorizontalEdge {
    _actionBtnHorizontalEdge = actionBtnHorizontalEdge;
    
    if (_actionBtn) {
        [self setupSubviews];
    }
}

- (void)setActionBtnCornerRadius:(CGFloat)actionBtnCornerRadius {
    _actionBtnCornerRadius = actionBtnCornerRadius;
    
    if (_actionBtn) {
        _actionBtn.layer.cornerRadius = actionBtnCornerRadius;
    }
}

- (void)setActionBtnBorderWidth:(CGFloat)actionBtnBorderWidth {
    _actionBtnBorderWidth = actionBtnBorderWidth;
    
    if (_actionBtn) {
        _actionBtn.layer.borderWidth = actionBtnBorderWidth;
    }
}

- (void)setActionBtnBorderColor:(UIColor *)actionBtnBorderColor {
    _actionBtnBorderColor = actionBtnBorderColor;
    
    if (_actionBtn) {
        _actionBtn.layer.borderColor = actionBtnBorderColor.CGColor;
    }
}

- (void)setActionBtnTitleColor:(UIColor *)actionBtnTitleColor {
    _actionBtnTitleColor = actionBtnTitleColor;
    
    if (_actionBtn) {
        [_actionBtn setTitleColor:actionBtnTitleColor forState:UIControlStateNormal];
    }
}

- (void)setActionBtnBackgroundColor:(UIColor *)actionBtnBackgroundColor {
    _actionBtnBackgroundColor = actionBtnBackgroundColor;
    
    if (_actionBtn) {
        [_actionBtn setBackgroundColor:actionBtnBackgroundColor];
    }
}

- (void)setActionBtnHeight:(CGFloat)actionBtnHeight {
    _actionBtnHeight = actionBtnHeight;
    
    if (_actionBtn) {
        [self setupSubviews];
    }
}

@end
