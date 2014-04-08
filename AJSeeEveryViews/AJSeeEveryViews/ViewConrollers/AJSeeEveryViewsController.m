//
//  AJSeeEveryViewsController.m
//  AJSeeEveryViews
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJSeeEveryViewsController.h"
#import "AJSeeEveryViews.h"

@interface AJSeeEveryViewsController ()

@property (nonatomic, strong) NSMutableArray *viewController;
@property (nonatomic, strong) AJSeeEveryViews *v;

@end

@implementation AJSeeEveryViewsController

- (void)initialization {

}

- (id)init
{
    self = [super init];
    if (self) {
        [self initialization];
        
        _viewController = [NSMutableArray new];
        
    }
    return self;
}

- (id)initWithViewControllers:(NSArray*)viewControllers {
    self = [super init];
    if (self) {
        [self initialization];
        
        _viewController = [NSMutableArray arrayWithArray:viewControllers];
    }
    return self;
}

- (void)loadView {
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    _v = [[AJSeeEveryViews alloc] initWithFrame:frame];
    
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
    
}

- (void)insertViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    
}

- (void)setMainViews {
    [_viewController enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_v pushMainView:((UIViewController*)obj).view];
    }];
}

#pragma mark - UIScrollViewDelegate

// ... 

@end
