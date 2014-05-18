//
//  AJPaperFlowMainView.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowView.h"

@interface AJPaperFlowMainView : AJPaperFlowView

@property (nonatomic, strong) UIScrollView *scrollView;

- (void)pushView:(UIView *)view;

@end
