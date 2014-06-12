//
//  AJMainViewDefaultState.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJMainViewDefaultState.h"
#import "AJMainViewFullScreenState.h"

#import "AJPaperFlowView.h"

@implementation AJMainViewDefaultState

- (CGRect)frame {
    AJPaperFlowView *view = (AJPaperFlowView *)self.context.view;

    CGRect originFrame = view.superview.bounds;
    CGRect f = originFrame;
    f.size.height = (int)(CGRectGetHeight(originFrame) * (1.0 - view.subViewsProportion) + kOverlap);

    return f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[AJMainViewFullScreenState alloc] initWithContext:self.context];
}

@end
