//
//  AJPaperFlowViewControllerSpec.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 28/04/14.
//  Copyright 2014 Alexandre Joly. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AJPaperFlowViewController.h"

@interface AJPaperFlowViewController (UnitTest)

@property (nonatomic, weak) NSMutableArray *viewControllers;

@end

SPEC_BEGIN(AJPaperFlowViewControllerSpec)

describe(@"AJPaperFlowViewController", ^{

    context(@"initWithViewControllers", ^{
        
        it(@"should initialize the viewControllers array", ^{
            AJPaperFlowViewController *paperFlowVC = [[AJPaperFlowViewController alloc] initWithViewControllers:
                                                        @[[UIViewController new],
                                                          [UIViewController new]]];
            
            [[paperFlowVC.viewControllers shouldNot] beNil];
            [[paperFlowVC.viewControllers shouldNot] beEmpty];
        });
        
    });
    
});

SPEC_END
