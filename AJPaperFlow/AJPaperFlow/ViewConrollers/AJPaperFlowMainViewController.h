//
//  AJPaperFlowMainViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AJPaperFlowMainViewController;

@protocol AJPaperFlowMainDelegate <NSObject>

- (void)ajPaperFlowViewControllerDidChangeCurrentViewController:(UIViewController*)currentViewController;

@end

@interface AJPaperFlowMainViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) id<AJPaperFlowMainDelegate> delegate;

- (void)setViewControllers:(NSArray*)viewControllers;

@end
