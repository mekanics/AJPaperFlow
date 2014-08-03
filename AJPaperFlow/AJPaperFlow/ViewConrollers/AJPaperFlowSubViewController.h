//
//  AJPaperFlowSubViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AJPaperFlowSubViewController;
@class AJSubViewState;

@protocol AJPaperFlowSubDelegate <NSObject>

@required
- (void)ajPaperFlowSubViewController:(AJPaperFlowSubViewController *)controller didHandleTap:(UITapGestureRecognizer *)recognizer;
- (void)ajPaperFlowSubViewController:(AJPaperFlowSubViewController *)controller didHandlePan:(UIPanGestureRecognizer *)recognizer toRelativeZoom:(CGFloat)relativeZoom;

@end

@interface AJPaperFlowSubViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) id<AJPaperFlowSubDelegate> delegate;
@property (nonatomic, strong) AJSubViewState *state;

- (void)setViewControllers:(NSArray*)viewControllers;
- (void)scrollToLeft;

@end