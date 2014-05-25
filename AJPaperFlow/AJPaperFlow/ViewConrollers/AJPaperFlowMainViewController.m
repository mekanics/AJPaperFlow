//
//  AJPaperFlowMainViewController.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 11/05/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowMainViewController.h"
#import "AJPaperFlowMainView.h"

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

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
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
    
    if ([_delegate respondsToSelector:@selector(ajPaperFlowViewControllerDidChangeCurrentViewController:)]) {
        [_delegate ajPaperFlowViewControllerDidChangeCurrentViewController:_currentViewController];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    NSLog(@"Swiped vertically...");
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
