//
//  AJPaperFlowViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJPaperFlowViewController : UIViewController <UIScrollViewDelegate>

- (id)initWithViewControllers:(NSArray *)viewControllers;

- (void)addViewController:(UIViewController *)viewController;
- (void)insertViewController:(UIViewController *)viewController atIndex:(NSInteger)index;

@end
