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
@property (nonatomic, strong) AJPaperFlowMainViewController *context;

- (instancetype)initWithContext:(AJPaperFlowMainViewController *)context;

- (void)handleTap:(UITapGestureRecognizer *)recognizer;

@end
