//
//  AJMainViewStateSpec.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 12/06/14.
//  Copyright 2014 Alexandre Joly. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AJMainViewState.h"


SPEC_BEGIN(AJMainViewStateSpec)

describe(@"AJMainViewState", ^{

    context(@"init", ^{
        it(@"should not be allowed", ^{
            [[theBlock(^{
                __unused id ajMainViewState = [[AJMainViewState alloc] init];
            }) should] raiseWithName:NSInternalInconsistencyException];
        });
    });

    context(@"initWithContext", ^{
        it(@"should have a context", ^{

            AJPaperFlowMainViewController *context = [AJPaperFlowMainViewController new];
            AJMainViewState *state = [[AJMainViewState alloc] initWithContext:context];

            [[state.context shouldNot] beNil];
            
        });
    });

});

SPEC_END
