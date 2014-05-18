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
    [_views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = (UIView*)obj;
        [view removeFromSuperview];
    }];

    [_views removeAllObjects];
}

//
//- (void)layoutSubviews {
//    self.layer.masksToBounds = YES;
//    
//    CGRect subScrollViewFrame = CGRectMake(0, CGRectGetMaxY(mainScrollViewFrame) - kOverlap, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) * _subViewsProportion);
//    _subScrollView.frame = subScrollViewFrame;
//}
//
//#pragma mark - public
//
//- (void)pushMainView:(UIView*)view {
////    CGRect frame = _mainScrollView.bounds;
////    frame.origin.x = [_mainViews count] * CGRectGetWidth(_mainScrollView.frame);
////    view.frame = frame;
////
////    view.layer.cornerRadius = _cornerRadius;
////    
////    [_mainScrollView addSubview:view];
////
////    _mainScrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame), CGRectGetHeight(_mainScrollView.frame));
////
////    [_mainViews addObject:view];
//}
//
//- (void)pushSubView:(UIView *)view {
//    CGRect frame = self.bounds;
//    frame.origin.x = CGRectGetMaxX(((UIView*)[_subViews lastObject]).frame) + 1;
//    frame.size.width = CGRectGetWidth(self.frame);
//    view.frame = frame;
//    [self minimizeView:view];
//    
//    view.layer.cornerRadius = _cornerRadius;
//    
//    [_subScrollView addSubview:view];
//    
//    _subScrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame) + 1, CGRectGetHeight(_subScrollView.frame));
//    
//    [_subViews addObject:view];
//}
//
//- (void)removeSubViews {
//    [_subViews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [(UIView*)obj removeFromSuperview];
//    }];
//    
//    [_subViews removeAllObjects];
//}
//
//#pragma mark - 
//
//- (void)minimizeView:(UIView*)view {
//    CGRect frame = view.frame;
//    
//    CGAffineTransform transform = CGAffineTransformMakeScale(_subViewsProportion, _subViewsProportion);
//    view.transform = transform;
//    
//    frame.size.width = CGRectGetWidth(view.frame);
//    frame.size.height = CGRectGetHeight(view.frame);
//    view.frame = frame;
//}
//
//- (void)maximizeView:(UIView*)view {
//    CGRect frame = view.frame;
//    
//    CGAffineTransform transform = CGAffineTransformMakeScale(1/_subViewsProportion, 1/_subViewsProportion);
//    view.transform = transform;
//    
//    frame.size.width = CGRectGetWidth(view.frame);
//    frame.size.height = CGRectGetHeight(view.frame);
//    view.frame = frame;
//}
//
//
//#pragma mark - Setter
//
//- (void)setCornerRadius:(CGFloat)cornerRadius {
//    _cornerRadius = cornerRadius;
//    
//    self.layer.cornerRadius = _roundedCorner ? _cornerRadius : 0;
//}
//
//- (void)setSubViewsProportion:(CGFloat)subViewsProportion {
//    _subViewsProportion = subViewsProportion;
//}
//
@end
