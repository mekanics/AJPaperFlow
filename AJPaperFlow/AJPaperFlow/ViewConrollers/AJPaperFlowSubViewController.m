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
    _v.delegate = self;

    self.view = _v;

    _v.backgroundColor = [UIColor grayColor];
    _v.layer.borderColor = [UIColor redColor].CGColor;
    _v.layer.borderWidth = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
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
    NSLog(@"Swiped horizontally...");
}

@end
