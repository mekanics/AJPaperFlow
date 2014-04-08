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

@property (nonatomic, strong) NSMutableArray *mainViews;

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

        _mainViews = [[NSMutableArray alloc] init];
        
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
    _mainScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - public

- (void)pushMainView:(UIView*)view {
    [_mainViews addObject:view];

    CGRect frame = _mainScrollView.bounds;
    frame.origin.x = ([_mainViews count] - 1) * CGRectGetWidth(_mainScrollView.frame);
    view.frame = frame;

    [_mainScrollView addSubview:view];

    _mainScrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame), CGRectGetHeight(_mainScrollView.frame));
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
