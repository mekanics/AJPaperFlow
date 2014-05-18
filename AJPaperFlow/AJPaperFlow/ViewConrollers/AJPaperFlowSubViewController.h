//
//  AJPaperFlowSubViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AJPaperFlowSubDelegate <NSObject>

@end

@interface AJPaperFlowSubViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, retain) id<AJPaperFlowSubDelegate> delegate;

- (void)setViewControllers:(NSArray*)viewControllers;

@end