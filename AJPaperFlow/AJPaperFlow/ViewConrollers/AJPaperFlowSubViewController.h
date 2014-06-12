//
//  AJPaperFlowSubViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP/POP.h>

typedef enum {
    kAJPaperFlowSubViewStateDown = 0,
    kAJPaperFlowSubViewStateFullScreen,
    kAJPaperFlowSubViewStateHidden,
} AJPaperFlowSubViewState;

@class AJPaperFlowSubViewController;

@protocol AJPaperFlowSubDelegate <NSObject>

- (void)ajPaperFlowSubViewController:(AJPaperFlowSubViewController*)controller willSetState:(AJPaperFlowSubViewState)newState fromState:(AJPaperFlowSubViewState)oldState;
- (void)ajPaperFlowSubViewController:(AJPaperFlowSubViewController*)controller didSetState:(AJPaperFlowSubViewState)newState fromState:(AJPaperFlowSubViewState)oldState;

@end

@interface AJPaperFlowSubViewController : UIViewController <UIScrollViewDelegate, POPAnimationDelegate>

@property (nonatomic, retain) id<AJPaperFlowSubDelegate> delegate;

- (void)setViewControllers:(NSArray*)viewControllers;
- (void)scrollToLeft;

- (void)showViews;
- (void)hideViews;

@end