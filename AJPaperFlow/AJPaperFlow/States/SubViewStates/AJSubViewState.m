//
//  AJSubViewState.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 15/06/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJSubViewState.h"

@implementation AJSubViewState

- (id)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer. use initWithContext: instead"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithContext:(AJPaperFlowSubViewController *)context {
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}

- (CGRect)frame {
    return CGRectZero;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
