//
//  AJMainViewHiddenState.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 17/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJMainViewHiddenState.h"
#import "AJMainViewDefaultState.h"

#import "AJPaperFlowView.h"

@implementation AJMainViewHiddenState

- (CGRect)frame {
    return CGRectZero;
}

- (CGSize)scale {
    return CGSizeMake(0.9, 0.9);
}

- (CGFloat)opacity {
    return 0.3f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[AJMainViewDefaultState alloc] initWithContext:self.context];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // do nothing
}

#pragma mark -

- (void)subViewDidHandleTap:(UITapGestureRecognizer *)recognizer {
    // do nothing
}

- (void)subViewDidHandlePan:(UIPanGestureRecognizer *)recognizer {
    // TODO
}

@end
