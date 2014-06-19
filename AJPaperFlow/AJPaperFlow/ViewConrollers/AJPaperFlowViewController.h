//
//  AJPaperFlowViewController.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AJPaperFlowMainViewController.h"
#import "AJPaperFlowSubViewController.h"

@interface AJPaperFlowViewController : UIViewController <AJPaperFlowMainDelegate, AJPaperFlowSubDelegate>

- (id)initWithViewControllers:(NSArray *)viewControllers;

@end
