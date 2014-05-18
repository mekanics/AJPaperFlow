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

        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _originFrame = self.superview.bounds;

    [_views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *curView = (UIView*)obj;

        [self zoomView:curView];

        if (idx) {
            CGRect frame = curView.frame;
            frame.origin.x = 1 + CGRectGetMaxX(((UIView*)[_views objectAtIndex:idx-1]).frame);
            curView.frame = frame;
        }

    }];

    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(((UIView*)[_views lastObject]).frame) + 1, CGRectGetHeight(self.frame));
}

- (CGFloat)subViewsZoom {
    CGFloat proportion = CGRectGetHeight(self.frame) / CGRectGetHeight(_originFrame);

    proportion = MAX(proportion, self.subViewsProportion);
    proportion = MIN(proportion, 1.0);

    return proportion;
}

- (void)pushView:(UIView *)view {
    CGRect frame = _originFrame;
    frame.origin.x = CGRectGetMaxX(((UIView*)[_views lastObject]).frame) + 1;
    frame.size.width = CGRectGetWidth(_originFrame);
    view.frame = frame;
    [self zoomView:view];
    
    view.layer.cornerRadius = self.cornerRadius;
    
    [self.scrollView addSubview:view];
        
    [_views addObject:view];
}

#pragma mark -

- (void)zoomView:(UIView*)view {
    CGRect frame = view.frame;
    
    CGAffineTransform transform = CGAffineTransformMakeScale([self subViewsZoom], [self subViewsZoom]);
    view.transform = transform;
    
    frame.size.width = CGRectGetWidth(view.frame);
    frame.size.height = CGRectGetHeight(view.frame);
    view.frame = frame;
}

@end
