//
//  AJPaperFlowMainViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP/POP.h>

//typedef enum {
//    kAJPaperFlowMainViewStateTop = 0,
//    kAJPaperFlowMainViewStateFullScreen,
//    kAJPaperFlowMainViewStateBack,
//} AJPaperFlowMainViewState;

@class AJPaperFlowMainViewController;
@class AJMainViewState;

@protocol AJPaperFlowMainDelegate <NSObject>

- (void)ajPaperFlowMainViewControllerDidChangeCurrentViewController:(UIViewController*)currentViewController;
- (void)ajPaperFlowMainViewController:(AJPaperFlowMainViewController*)controller willSetState:(AJMainViewState*)newState fromState:(AJMainViewState*)oldState;
- (void)ajPaperFlowMainViewController:(AJPaperFlowMainViewController*)controller didSetState:(AJMainViewState*)newState fromState:(AJMainViewState*)oldState;

@end

@interface AJPaperFlowMainViewController : UIViewController <UIScrollViewDelegate, POPAnimationDelegate>

@property (nonatomic, strong) id<AJPaperFlowMainDelegate> delegate;
@property (nonatomic, strong) AJMainViewState *state;

- (void)setViewControllers:(NSArray*)viewControllers;

@end
