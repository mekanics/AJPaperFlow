//
//  AJPaperFlowMainViewController.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowMainViewController.h"
#import "AJPaperFlowMainView.h"

#import "AJMainViewDefaultState.h"

#import <POP/POP.h>

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

    _state = [[AJMainViewDefaultState alloc] initWithContext:self];
    _v.frame = self.state.frame;
}

- (void)transitionToCurrentState {
    CGRect frame = _state.frame;

    if (!CGRectEqualToRect(frame, CGRectZero)) {
        POPSpringAnimation *frameAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        frameAnimation.toValue = [NSValue valueWithCGRect:frame];
        frameAnimation.springBounciness = 6.f;
        [self.view pop_addAnimation:frameAnimation forKey:@"frameAnimation"];
    }


    CGSize scale = _state.scale;

    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue  = [NSValue valueWithCGSize:scale];
    scaleAnimation.springBounciness = 6.f;
    [self.view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];


    CGFloat opacity = _state.opacity;

    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(opacity);
    [self.view.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];

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
    [_state handleTap:recognizer];
}


#pragma mark - Setter

- (void)setState:(AJMainViewState *)state {
    _state = state;

    [self transitionToCurrentState];

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
