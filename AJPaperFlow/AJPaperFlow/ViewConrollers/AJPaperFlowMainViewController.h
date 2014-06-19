//
//  AJPaperFlowMainViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AJPaperFlowMainViewController;
@class AJMainViewState;

@protocol AJPaperFlowMainDelegate <NSObject>

@required
- (void)ajPaperFlowMainViewControllerDidChangeCurrentViewController:(UIViewController *)currentViewController;

- (void)ajPaperFlowMainViewController:(AJPaperFlowMainViewController *)controller didHandleTap:(UITapGestureRecognizer *)recognizer;
- (void)ajPaperFlowMainViewController:(AJPaperFlowMainViewController *)controller didHandlePan:(UIPanGestureRecognizer *)recognizer;
@end

@interface AJPaperFlowMainViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) id<AJPaperFlowMainDelegate> delegate;
@property (nonatomic, strong) AJMainViewState *state;

- (void)setViewControllers:(NSArray*)viewControllers;

@end
