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

@end

@implementation AJPaperFlowMainView

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
    CGRect scrollViewFrame = _originFrame;
    scrollViewFrame.size.height = (int)(CGRectGetHeight(_originFrame) * (1.0-self.subViewsProportion) + kOverlap);

    self.frame = scrollViewFrame;

    self.layer.masksToBounds = YES;

    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}


- (void)pushView:(UIView *)view {
    CGRect frame = self.bounds;
    frame.origin.x = [_views count] * CGRectGetWidth(self.frame);
    view.frame = frame;
    
    view.layer.cornerRadius = self.cornerRadius;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.scrollView addSubview:view];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame), CGRectGetHeight(self.frame));
    
    [_views addObject:view];
}


#pragma mark - Setter


@end
