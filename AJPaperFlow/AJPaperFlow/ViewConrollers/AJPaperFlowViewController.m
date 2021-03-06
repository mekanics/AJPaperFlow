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

#import "AJMainViewState.h"
#import "AJSubViewState.h"

@interface AJPaperFlowViewController ()

@property (nonatomic, strong) AJPaperFlowMainViewController *mainViewController;
@property (nonatomic, strong) AJPaperFlowSubViewController *subViewController;

@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) UIViewController *currentMainViewController;

@end

@implementation AJPaperFlowViewController

- (void)initialization {
    _mainViewController = [[AJPaperFlowMainViewController alloc] init];
    _mainViewController.delegate = self;
    
    _subViewController = [[AJPaperFlowSubViewController alloc] init];
    _subViewController.delegate = self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initialization];

        _viewControllers = [NSMutableArray new];
    }
    return self;
}

- (id)initWithViewControllers:(NSArray *)viewControllers {
    self = [super init];
    if (self) {
        [self initialization];
        
        _viewControllers = [NSMutableArray arrayWithArray:viewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    self.view.frame = [[UIScreen mainScreen] bounds];
}

- (void)setMainViewControllers:(NSArray *)viewControllers {
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSAssert([obj conformsToProtocol:@protocol(AJPaperFlowProtocol)], @"'%@' doesn't conform to the protocol 'AJPaperFlowProtocol'", NSStringFromClass([obj class]));
    }];
    
    [_mainViewController setViewControllers:viewControllers];
}

- (void)setSubViewControllers:(NSArray *)viewControllers {
    [_subViewController setViewControllers:viewControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view addSubview:_mainViewController.view];
    [self.view addSubview:_subViewController.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self setMainViewControllers:_viewControllers];
    [self setSubViewControllers:((id<AJPaperFlowProtocol>)[_viewControllers firstObject]).subViewControllers];
}

#pragma mark - AJPaperFlowMainDelegate

- (void)ajPaperFlowMainViewControllerDidChangeCurrentViewController:(UIViewController *)currentViewController {

    if (_currentMainViewController != currentViewController) {
        _currentMainViewController = currentViewController;

        [self setSubViewControllers:((id<AJPaperFlowProtocol>)currentViewController).subViewControllers];
    }

    [_subViewController scrollToLeft];
}

- (void)ajPaperFlowMainViewController:(AJPaperFlowMainViewController *)controller didHandleTap:(UITapGestureRecognizer *)recognizer {

    // TODO
}

- (void)ajPaperFlowMainViewController:(AJPaperFlowMainViewController *)controller didHandlePan:(UIPanGestureRecognizer *)recognizer {

    // TODO
}

#pragma mark - AJPaperFlowSubDelegate

- (void)ajPaperFlowSubViewController:(AJPaperFlowSubViewController *)controller didHandleTap:(UITapGestureRecognizer *)recognizer {

    [_mainViewController.state subViewDidHandleTap:recognizer];
}

- (void)ajPaperFlowSubViewController:(AJPaperFlowSubViewController *)controller didHandlePan:(UIPanGestureRecognizer *)recognizer {

    [_mainViewController.state subViewDidHandlePan:recognizer];

}

@end
