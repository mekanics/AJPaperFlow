//
//  AJMainViewState.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AJPaperFlowMainViewController.h"

@interface AJMainViewState : NSObject

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, readonly) CGSize scale;
@property (nonatomic, readonly) CGFloat opacity;

@property (nonatomic, strong) AJPaperFlowMainViewController *context;

- (instancetype)initWithContext:(AJPaperFlowMainViewController *)context;

- (void)handleTap:(UITapGestureRecognizer *)recognizer;
- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

- (void)subViewDidHandleTap:(UITapGestureRecognizer *)recognizer;
- (void)subViewDidHandlePan:(UIPanGestureRecognizer *)recognizer toRelativeZoom:(CGFloat)relativeZoom;

@end
