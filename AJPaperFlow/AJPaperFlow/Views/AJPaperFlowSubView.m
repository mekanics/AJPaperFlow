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

@end

@implementation AJPaperFlowSubView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _originFrame = frame;
        _views = [[NSMutableArray alloc] init];

        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _originFrame = self.superview.bounds;
    CGRect scrollViewFrame = _originFrame;
    scrollViewFrame.origin.y = (int)(CGRectGetHeight(_originFrame) - (CGRectGetHeight(_originFrame) * self.subViewsProportion));
    scrollViewFrame.size.height = (int)(CGRectGetHeight(scrollViewFrame) * self.subViewsProportion);

    self.frame = scrollViewFrame;

    self.layer.masksToBounds = YES;
}

- (void)pushView:(UIView *)view {
    CGRect frame = _originFrame;
    frame.origin.x = CGRectGetMaxX(((UIView*)[_views lastObject]).frame) + 1;
    frame.size.width = CGRectGetWidth(_originFrame);
    view.frame = frame;
    [self minimizeView:view];
    
    view.layer.cornerRadius = self.cornerRadius;
    
    [_scrollView addSubview:view];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame) + 1, CGRectGetHeight(self.frame));
    
    [_views addObject:view];
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
