//
//  AJPaperFlowSubViewController.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowSubViewController.h"
#import "AJPaperFlowSubView.h"

@interface AJPaperFlowSubViewController ()

@property (nonatomic, strong) AJPaperFlowSubView *v;

@end

@implementation AJPaperFlowSubViewController

- (void)loadView {
    _v = [[AJPaperFlowSubView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _v.scrollView.delegate = self;

    self.view = _v;

    _v.layer.borderColor = [UIColor redColor].CGColor;
    _v.layer.borderWidth = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _v.frame = [self frameForState:kAJPaperFlowSubViewStateDown];
    _v.layer.masksToBounds = YES;
}


- (CGRect)frameForState:(AJPaperFlowSubViewState)state {

    CGRect stateFrame = CGRectZero;
    CGRect originBounds = _v.superview.bounds;

    switch (state) {
        case kAJPaperFlowSubViewStateDown:
            stateFrame = originBounds;
            stateFrame.origin.y = (int)(CGRectGetHeight(originBounds) - (CGRectGetHeight(originBounds) * _v.subViewsProportion));
            stateFrame.size.height = (int)(CGRectGetHeight(stateFrame) * _v.subViewsProportion);
            break;

        case kAJPaperFlowSubViewStateFullScreen:
            stateFrame = originBounds;
            break;

        default:
            break;
    }

    return stateFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewControllers:(NSArray *)viewControllers {
    [_v removeViews];
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_v pushView:((UIViewController*)obj).view];
    }];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {

    static CGRect originalFrame; // or you could make this a non-static class ivar

    if (recognizer.state == UIGestureRecognizerStateBegan) {
        originalFrame = self.view.frame;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.view];
        CGRect newFrame = originalFrame;
        newFrame.origin.y += translation.y;
        newFrame.size.height += (translation.y * -1);
        self.view.frame = newFrame;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat proportion = CGRectGetHeight(self.view.frame) / CGRectGetHeight(self.view.superview.frame);
        CGFloat midProportion = (1.0 + _v.subViewsProportion)/2.0;

        if (proportion > midProportion) {
            self.view.frame = [self frameForState:kAJPaperFlowSubViewStateFullScreen];
        } else {
            self.view.frame = [self frameForState:kAJPaperFlowSubViewStateDown];
        }
    }

}

@end
