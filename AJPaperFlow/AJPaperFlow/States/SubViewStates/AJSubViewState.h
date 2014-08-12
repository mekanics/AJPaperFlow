//
//  AJSubViewState.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 15/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AJPaperFlowSubViewController.h"

@interface AJSubViewState : NSObject

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, readonly) BOOL pagingEnabled;
@property (nonatomic, strong) AJPaperFlowSubViewController *context;

- (instancetype)initWithContext:(AJPaperFlowSubViewController *)context;

- (void)handlePan:(UIPanGestureRecognizer *)recognizer;
- (void)handleTap:(UITapGestureRecognizer *)recognizer;

- (void)mainViewDidHandleTap:(UITapGestureRecognizer *)recognizer;
- (void)mainViewDidHandlePan:(UIPanGestureRecognizer *)recognizer;

@end
