//
//  AJSeeEveryViews.m
//  AJSeeEveryViews
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJSeeEveryViews.h"
#import <QuartzCore/QuartzCore.h>

#define kOverlap 20.0f

@interface AJSeeEveryViews ()

@end

@implementation AJSeeEveryViews

- (void)initialization {
    _roundedCorner = YES;
    _cornerRadius = 5.0f;
    _subViewsProportion = 0.47;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self addSubview:_mainScrollView];
    }
    return self;
}

- (void)layoutSubviews {
    self.layer.cornerRadius = _roundedCorner ? _cornerRadius : 0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor redColor]; //TODO: clearColor
    
    CGRect mainScrollViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * (1.0-_subViewsProportion) + kOverlap);
    _mainScrollView.frame = mainScrollViewFrame;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.backgroundColor = [UIColor greenColor];
}

#pragma mark - Setter

- (void)setRoundedCorner:(BOOL)roundedCorner {
    _roundedCorner = roundedCorner;
    
    self.layer.cornerRadius = _roundedCorner ? _cornerRadius : 0;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = _roundedCorner ? _cornerRadius : 0;
}

- (void)setSubViewsProportion:(CGFloat)subViewsProportion {
    _subViewsProportion = subViewsProportion;
}

@end
