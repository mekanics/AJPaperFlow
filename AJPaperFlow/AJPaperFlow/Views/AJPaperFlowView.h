//
//  AJPaperFlowView.h
//  AJPaperFlow
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOverlap 20.0f

@interface AJPaperFlowView : UIScrollView

@property (nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat subViewsProportion UI_APPEARANCE_SELECTOR;

@end
