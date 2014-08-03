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

- (void)subViewDidHandlePan:(UIPanGestureRecognizer *)recognizer toRelativeZoom:(CGFloat)relativeZoom {

    CGFloat inverseRelativeZoom = 1.0 - relativeZoom;

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // do nothing
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat widthScale = self.scale.width + (1.0 - self.scale.width) * inverseRelativeZoom;
        widthScale = MIN(1.0, widthScale);
        widthScale = MAX(self.scale.width, widthScale);

        CGFloat heightScale = self.scale.height + (1.0 - self.scale.height) * inverseRelativeZoom;
        heightScale = MIN(1.0, heightScale);
        heightScale = MAX(self.scale.width, heightScale);

        self.context.view.transform = CGAffineTransformMakeScale(widthScale, heightScale);

        self.context.view.alpha = inverseRelativeZoom;

    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (relativeZoom < 0.5) {
            self.context.state = [[AJMainViewDefaultState alloc] initWithContext:self.context];
        } else {
            self.context.state = [[AJMainViewHiddenState alloc] initWithContext:self.context];
        }

    }

}

@end
