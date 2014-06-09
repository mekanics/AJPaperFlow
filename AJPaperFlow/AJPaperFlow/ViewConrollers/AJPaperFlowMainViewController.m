//
//  AJPaperFlowMainViewController.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowMainViewController.h"
#import "AJPaperFlowMainView.h"

#import <POPSpringAnimation.h>

@interface AJPaperFlowMainViewController ()

@property (nonatomic, strong) AJPaperFlowMainView *v;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *currentViewController;

@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation AJPaperFlowMainViewController

- (void)loadView {
    _v = [[AJPaperFlowMainView alloc] initWithFrame:CGRectZero];
    _v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _v.scrollView.delegate = self;

    self.view = _v;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGRect originFrame = _v.superview.bounds;
    CGRect scrollViewFrame = originFrame;
    scrollViewFrame.size.height = (int)(CGRectGetHeight(originFrame) * (1.0-_v.subViewsProportion) + kOverlap);

    _v.frame = scrollViewFrame;
}

#pragma mark Setter

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
        
    [_v removeViews];
    
    if (!_v) {
        id __unused view = self.view;
    }
    
    [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_v pushView:((UIViewController *)obj).view];
        
        if (!idx) {
            [self setCurrentViewController:obj];
        }
        
    }];
}

- (void)setCurrentViewController:(UIViewController *)currentViewController {
    _currentViewController = currentViewController;
    
    if ([_delegate respondsToSelector:@selector(ajPaperFlowMainViewControllerDidChangeCurrentViewController:)]) {
        [_delegate ajPaperFlowMainViewControllerDidChangeCurrentViewController:_currentViewController];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Tap...");

    switch (_state) {
        case kAJPaperFlowMainViewStateTop:
            self.state = kAJPaperFlowMainViewStateFullScreen;
            [self sizeUpView:_v];

            break;

        case kAJPaperFlowMainViewStateFullScreen:
            self.state = kAJPaperFlowMainViewStateTop;
            [self sizeDownView:_v];

            break;

        default:
            break;
    }
}

- (void)sizeUpView:(UIView *)view {
    POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    frameAnimation.toValue = [NSValue valueWithCGRect:view.superview.bounds];
    frameAnimation.springBounciness = 10.f;
    [view pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
}

- (void)sizeDownView:(UIView *)view {

    CGRect originFrame = view.superview.bounds;
    CGRect scrollViewFrame = originFrame;
    scrollViewFrame.size.height = (int)(CGRectGetHeight(originFrame) * (1.0-_v.subViewsProportion) + kOverlap);

    POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    frameAnimation.toValue = [NSValue valueWithCGRect:scrollViewFrame];
    frameAnimation.springBounciness = 10.f;
    [view pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
}

#pragma mark - Setter

- (void)setState:(AJPaperFlowMainViewState)state {

    if (state == _state) return;

    AJPaperFlowMainViewState oldState = _state;
    AJPaperFlowMainViewState newState = state;

    if ([_delegate respondsToSelector:@selector(ajPaperFlowMainViewController:willSetState:fromState:)]) {
        [_delegate ajPaperFlowMainViewController:self willSetState:newState fromState:oldState];
    }

    _state = state;

    if ([_delegate respondsToSelector:@selector(ajPaperFlowMainViewController:didSetState:fromState:)]) {
        [_delegate ajPaperFlowMainViewController:self didSetState:newState fromState:oldState];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    
    _currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"current page: %ld", (long)_currentPage);
    
    if ([_viewControllers count] < _currentPage) {
        return;
    }
    self.currentViewController = [_viewControllers objectAtIndex:_currentPage];
}

@end
