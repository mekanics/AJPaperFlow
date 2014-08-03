//
//  AJPaperFlowSubViewController.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowSubViewController.h"
#import "AJPaperFlowSubView.h"

#import "AJSubViewDefaultState.h"

#import <POP/POP.h>

@interface AJPaperFlowSubViewController ()

@property (nonatomic, strong) AJPaperFlowSubView *v;

@property (nonatomic, strong) UIView *tappedSubview;

@end

@implementation AJPaperFlowSubViewController

- (void)loadView {
    _v = [[AJPaperFlowSubView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _v.scrollView.delegate = self;

    self.view = _v;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _state = [[AJSubViewDefaultState alloc] initWithContext:self];
    _v.frame = self.state.frame;
}

- (void)transitionToCurrentState {
    CGRect frame = _state.frame;

    POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    frameAnimation.toValue = [NSValue valueWithCGRect:frame];
    frameAnimation.springBounciness = 6.f;
    [self.view pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    [_v removeViews];
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_v pushView:((UIViewController*)obj).view];
    }];
}

- (void)scrollToLeft {
    [_v.scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    [self.state handlePan:recognizer];

    if ([_delegate respondsToSelector:@selector(ajPaperFlowSubViewController:didHandlePan:toRelativeZoom:)]) {
        [_delegate ajPaperFlowSubViewController:self didHandlePan:recognizer toRelativeZoom:_v.relativeSubViewsZoom];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self.state handleTap:recognizer];

    if ([_delegate respondsToSelector:@selector(ajPaperFlowSubViewController:didHandleTap:)]) {
        [_delegate ajPaperFlowSubViewController:self didHandleTap:recognizer];
    }
}

#pragma mark - Setter

- (void)setState:(AJSubViewState *)state {
    _state = state;

    [self transitionToCurrentState];
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidApply:(POPAnimation *)anim {
    if ([anim.name isEqualToString:@"tappedAnim"]) {
        [_v.scrollView scrollRectToVisible:_tappedSubview.frame animated:NO];
    }
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    if ([anim.name isEqualToString:@"tappedAnim"]) {
        _tappedSubview = nil;
    }
}

@end
