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
    _v.delegate = self;
    
    self.view = _v;
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
    if (_currentViewController == currentViewController) {
        return;
    }
    
    _currentViewController = currentViewController;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;

    _currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"current page: %ld", (long)_currentPage);

    if ([_viewControllers count] < _currentPage) {
        return;
    }

    self.currentViewController = [_viewControllers objectAtIndex:_currentPage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(ajPaperFlowViewControllerDidChangeCurrentViewController:)]) {
        [_delegate ajPaperFlowViewControllerDidChangeCurrentViewController:_currentViewController];
    }
}

@end
