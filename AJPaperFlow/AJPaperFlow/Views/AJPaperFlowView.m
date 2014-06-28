//
//  AJPaperFlowView.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowView.h"
#import <QuartzCore/QuartzCore.h>

@interface AJPaperFlowView ()

@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation AJPaperFlowView

- (void)initialization {
    _cornerRadius = 5.0f;
    _subViewsProportion = 0.47;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)removeViews {
    [_views enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = (UIView*)obj;
        [view removeFromSuperview];

        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width - CGRectGetWidth(view.frame), CGRectGetHeight(_scrollView.frame));
    }];

    [_views removeAllObjects];
}

@end
