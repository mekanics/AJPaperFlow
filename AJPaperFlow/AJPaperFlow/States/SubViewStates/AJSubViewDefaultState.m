//
//  AJSubViewDefaultState.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 15/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJSubViewDefaultState.h"
#import "AJSubViewFullScreenState.h"
#import "AJSubViewHiddenState.h"

#import "AJPaperFlowView.h"

@implementation AJSubViewDefaultState

- (CGRect)frame {
    AJPaperFlowView *view = (AJPaperFlowView *)self.context.view;

    CGRect originFrame = view.superview.bounds;
    CGRect f = originFrame;
    f.origin.y = (int)(CGRectGetHeight(originFrame) - (CGRectGetHeight(originFrame) * view.subViewsProportion));
    f.size.height = (int)(CGRectGetHeight(f) * view.subViewsProportion);

    return f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[AJSubViewFullScreenState alloc] initWithContext:self.context];

    // TODO: scroll to view
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    static CGRect originalFrame;
    AJPaperFlowView *view = (AJPaperFlowView *)self.context.view;

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        originalFrame = view.frame;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGRect newFrame = originalFrame;
        newFrame.origin.y += translation.y;
        newFrame.size.height += (translation.y * -1);
        view.frame = newFrame;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat proportion = CGRectGetHeight(view.frame) / CGRectGetHeight(view.superview.frame);
        CGFloat midProportion = (1.0 + view.subViewsProportion)/2.0;

        if (proportion > midProportion) {
            self.context.state = [[AJSubViewFullScreenState alloc] initWithContext:self.context];
        } else {
            self.context.state = [[AJSubViewDefaultState alloc] initWithContext:self.context];
        }
    }
}

#pragma mark -

- (void)mainViewDidHandleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[AJSubViewHiddenState alloc] initWithContext:self.context];
}

- (void)mainViewDidHandlePan:(UIPanGestureRecognizer *)recognizer {

}

@end
