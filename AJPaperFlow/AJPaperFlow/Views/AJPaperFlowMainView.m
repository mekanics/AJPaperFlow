//
//  AJPaperFlowMainView.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowMainView.h"

@interface AJPaperFlowMainView ()

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation AJPaperFlowMainView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _originFrame = frame;
        _views = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _originFrame = self.superview.bounds;
    CGRect scrollViewFrame = _originFrame;
    scrollViewFrame.size.height = CGRectGetHeight(_originFrame) * (1.0-self.subViewsProportion) + kOverlap;
    
    if (!CGRectEqualToRect(scrollViewFrame, self.frame)) {
        self.frame = scrollViewFrame;
    }
    
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.layer.masksToBounds = YES;
}


- (void)pushView:(UIView *)view {
    CGRect frame = self.bounds;
    frame.origin.x = [_views count] * CGRectGetWidth(self.frame);
    view.frame = frame;
    
    view.layer.cornerRadius = self.cornerRadius;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:view];
    
    self.contentSize = CGSizeMake(CGRectGetMaxX(view.frame), CGRectGetHeight(self.frame));
    
    [_views addObject:view];
}

- (void)removeViews {
    [_views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = (UIView*)obj;
        [view removeFromSuperview];
    }];
    
    [_views removeAllObjects];
}

#pragma mark - Setter


@end
