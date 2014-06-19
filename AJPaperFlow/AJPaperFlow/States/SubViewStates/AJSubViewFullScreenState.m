//
//  AJSubViewFullScreenState.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 16/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJSubViewFullScreenState.h"
#import "AJSubViewDefaultState.h"

#import "AJPaperFlowView.h"

@implementation AJSubViewFullScreenState

- (CGRect)frame {
    CGRect f = self.context.view.superview.bounds;
    return f;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {

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


@end
