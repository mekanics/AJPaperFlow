//
//  AJPaperFlowViewController.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJPaperFlowViewController.h"
#import "AJPaperFlowView.h"
#import "AJPaperFlowProtocol.h"

@interface AJPaperFlowViewController ()

@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) AJPaperFlowView *v;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIViewController<AJPaperFlowProtocol> *currentMainViewController;

@end

@implementation AJPaperFlowViewController

- (void)initialization {

}

- (id)init
{
    self = [super init];
    if (self) {
        [self initialization];
        
        _viewControllers = [NSMutableArray new];
        
    }
    return self;
}

- (id)initWithViewControllers:(NSArray*)viewControllers {
    NSParameterAssert(viewControllers);
    
    self = [super init];
    if (self) {
        [self initialization];
        
        _viewControllers = [NSMutableArray arrayWithArray:viewControllers];
    }
    return self;
}

- (void)loadView {
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    _v = [[AJPaperFlowView alloc] initWithFrame:frame];
    
    _v.mainScrollView.delegate = self;

    self.view = _v;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self setMainViews];
}

- (void)addViewController:(UIViewController *)viewController {
    NSAssert([viewController conformsToProtocol:@protocol(AJPaperFlowProtocol)], @"The viewcController doesn't conform to the protocol 'AJPaperFlowProtocol'");
    
    [_v pushMainView:viewController.view];
}

- (void)insertViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    
}

- (void)setMainViews {
    [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSAssert([obj conformsToProtocol:@protocol(AJPaperFlowProtocol)], @"The viewcController doesn't conform to the protocol 'AJPaperFlowProtocol'");
        
        [_v pushMainView:((UIViewController*)obj).view];
        
        if (!idx) [self setCurrentMainViewController:obj];
        
    }];
}

- (void)setSubViewsOfViewController:(UIViewController<AJPaperFlowProtocol>*)mainViewController {
    [_v removeSubViews];
    
    [mainViewController.subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_v pushSubView:((UIViewController*)obj).view];
    }];
}

#pragma mark Setter

- (void)setCurrentMainViewController:(UIViewController<AJPaperFlowProtocol> *)currentMainViewController {
    if (_currentMainViewController == currentMainViewController) return;
    
    _currentMainViewController = currentMainViewController;
    
    [self setSubViewsOfViewController:(UIViewController<AJPaperFlowProtocol> *)_currentMainViewController];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    _currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"current page: %ld", (long)_currentPage);

    if ([_viewControllers count] < _currentPage) return;
    
    self.currentMainViewController = [_viewControllers objectAtIndex:_currentPage];
}

@end
