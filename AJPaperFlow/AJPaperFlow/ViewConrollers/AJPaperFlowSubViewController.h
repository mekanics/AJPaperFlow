//
//  AJPaperFlowSubViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP/POP.h>

@class AJPaperFlowSubViewController;
@class AJSubViewState;

@protocol AJPaperFlowSubDelegate <NSObject>

- (void)ajPaperFlowSubViewController:(AJPaperFlowSubViewController*)controller willSetState:(AJSubViewState *)newState fromState:(AJSubViewState *)oldState;
- (void)ajPaperFlowSubViewController:(AJPaperFlowSubViewController*)controller didSetState:(AJSubViewState *)newState fromState:(AJSubViewState *)oldState;

@end

@interface AJPaperFlowSubViewController : UIViewController <UIScrollViewDelegate, POPAnimationDelegate>

@property (nonatomic, strong) id<AJPaperFlowSubDelegate> delegate;
@property (nonatomic, strong) AJSubViewState *state;

- (void)setViewControllers:(NSArray*)viewControllers;
- (void)scrollToLeft;

@end