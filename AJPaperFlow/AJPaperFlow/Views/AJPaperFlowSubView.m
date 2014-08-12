//
//  AJPaperFlowSubView.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowSubView.h"

#define kGap 1.5

@interface AJPaperFlowSubView ()

@property (nonatomic, assign) CGRect originFrame;

@end

@implementation AJPaperFlowSubView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _originFrame = frame;
        _views = [[NSMutableArray alloc] init];

        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        self.scrollView.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _originFrame = self.superview.bounds;

    CGRect scrollViewFrame = self.bounds;
    scrollViewFrame.origin.x -= kGap;
    scrollViewFrame.size.width += kGap;
    self.scrollView.frame = scrollViewFrame;

    [self zoomView];

    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(((UIView*)[_views lastObject]).frame) + 1, CGRectGetHeight(self.frame));
}

- (CGFloat)subViewsZoom {
    CGFloat proportion = CGRectGetHeight(self.frame) / CGRectGetHeight(_originFrame);

    proportion = MAX(proportion, self.subViewsProportion);
    proportion = MIN(proportion, 1.0);

    return proportion;
}

- (CGFloat)relativeSubViewsZoom {
    CGFloat relativeZoom = ([self subViewsZoom] - self.subViewsProportion) / (1.0 - self.subViewsProportion);
    relativeZoom = MIN(relativeZoom, 1.0);
    relativeZoom = MAX(relativeZoom, 0.0);
    return relativeZoom;
}

- (void)pushView:(UIView *)view {

    view.autoresizingMask = UIViewAutoresizingNone;

    CGRect frame = view.frame;
    frame.origin.x = (int)CGRectGetMaxX(((UIView*)[_views lastObject]).frame) + kGap;
    frame.origin.y = (int)0;
    view.frame = frame;

    view.layer.cornerRadius = self.cornerRadius;
    
    [self.scrollView addSubview:view];
        
    [_views addObject:view];
}

#pragma mark -

- (void)zoomView {
    float zoom = [self subViewsZoom];
    CGAffineTransform transform = CGAffineTransformMakeScale(zoom, zoom);

    self.scrollView.transform = transform;
}

@end
