//
//  AJSubViewHiddenState.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 15/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJSubViewHiddenState.h"
#import "AJSubViewDefaultState.h"

@implementation AJSubViewHiddenState

- (CGRect)frame {
    CGRect f = self.context.view.bounds;
    f.origin.y = CGRectGetMaxY(self.context.view.superview.frame) - 20;

    return f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[AJSubViewDefaultState alloc] initWithContext:self.context];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // TODO
}

#pragma mark -

- (void)mainViewDidHandleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[AJSubViewDefaultState alloc] initWithContext:self.context];
}

- (void)mainViewDidHandlePan:(UIPanGestureRecognizer *)recognizer {
    
}

@end
