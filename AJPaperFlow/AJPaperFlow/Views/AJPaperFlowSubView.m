//
//  AJPaperFlowSubView.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowSubView.h"

@interface AJPaperFlowSubView ()

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation AJPaperFlowSubView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _originFrame = frame;
        _views = [[NSMutableArray alloc] init];
        
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
//        [self addSubview:_scrollView];
//        _scrollView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    }
    return self;
}

- (void)layoutSubviews {
    _originFrame = self.superview.bounds;
    
    self.layer.masksToBounds = YES;
    
    CGRect scrollViewFrame = _originFrame;
    scrollViewFrame.origin.y = CGRectGetHeight(_originFrame) - (CGRectGetHeight(_originFrame) * self.subViewsProportion);
    scrollViewFrame.size.height *= self.subViewsProportion;
    self.frame = scrollViewFrame;
}

- (void)pushView:(UIView *)view {
    CGRect frame = _originFrame;
    frame.origin.x = CGRectGetMaxX(((UIView*)[_views lastObject]).frame) + 1;
    frame.size.width = CGRectGetWidth(_originFrame);
    view.frame = frame;
    [self minimizeView:view];
    
    view.layer.cornerRadius = self.cornerRadius;
    
    [self addSubview:view];
    
    self.contentSize = CGSizeMake(CGRectGetMaxX(view.frame) + 1, CGRectGetHeight(self.frame));
    
    [_views addObject:view];
}

- (void)removeViews {
    [_views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = (UIView*)obj;
        [view removeFromSuperview];
    }];
    
    [_views removeAllObjects];
}

#pragma mark -

- (void)minimizeView:(UIView*)view {
    CGRect frame = view.frame;
    
    CGAffineTransform transform = CGAffineTransformMakeScale(self.subViewsProportion, self.subViewsProportion);
    view.transform = transform;
    
    frame.size.width = CGRectGetWidth(view.frame);
    frame.size.height = CGRectGetHeight(view.frame);
    view.frame = frame;
}

@end
