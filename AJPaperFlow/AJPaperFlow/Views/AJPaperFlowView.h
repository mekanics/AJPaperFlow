//
//  AJPaperFlowView.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AJPaperFlowView : UIView

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIScrollView *subScrollView;


@property (nonatomic, assign) BOOL roundedCorner UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat subViewsProportion UI_APPEARANCE_SELECTOR;

- (void)pushMainView:(UIView*)view;

- (void)pushSubView:(UIView*)view;
- (void)removeSubViews;

@end
