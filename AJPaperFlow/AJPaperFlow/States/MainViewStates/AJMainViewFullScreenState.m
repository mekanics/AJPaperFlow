//
//  AJMainViewFullScreenState.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJMainViewFullScreenState.h"

#import "AJMainViewDefaultState.h"

@implementation AJMainViewFullScreenState

- (CGRect)frame {
    return self.context.view.superview.bounds;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    self.context.state = [[AJMainViewDefaultState alloc] initWithContext:self.context];
}

@end
