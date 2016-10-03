//
//  ViewController.m
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/5/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import "YCMainViewController.h"

#define kNavTitle @"REQUEST EQUIPMENT"

@interface YCMainViewController ()

@end

@implementation YCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupNavigationBar];
    [self setupToolbar];
}

- (void)setupNavigationBar {
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor blackColor]];
    [[[self navigationController] navigationBar] setTintColor:[UIColor yellowColor]];

    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.text = kNavTitle;
    titleView.font = [UIFont boldSystemFontOfSize:15.0];
    titleView.textColor = [UIColor whiteColor];
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    //right item
    // TODO
    
    //left item
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone"] style:UIBarButtonItemStyleDone target:self action:@selector(call)];
    self.navigationItem.rightBarButtonItem = barButtonItem;

}

- (void)setupToolbar {
//    UIView *view = [[UIView alloc] initWithFrame:[self.requestBarButton customView].bounds];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    [view.layer addSublayer:[self createBottomLineLayerInView:view]];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = [self.requestBarButton customView].bounds;
//    [btn setImage:[self imageWithView:[self.requestBarButton customView]] forState:UIControlStateNormal];
//    [view addSubview:[self.requestBarButton customView]];
//    [btn setImage:[self imageWithView:view] forState:UIControlStateSelected];
////    [btn addTarget:self action:@selector(resetCriteria:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.requestBarButton  = barButtonItem;
//    self.requestBarButton = [[UIBarButtonItem alloc] initWithCustomView:requestItemLabel];
//    
//    self.activeBarButton = [[UIBarButtonItem alloc] initWithCustomView:activeRentalLabel];
//    
//    self.openBarButton = [[UIBarButtonItem alloc] initWithCustomView:openRequestLabel];
//    
//    self.yardBarButton = [[UIBarButtonItem alloc] initWithCustomView:myYardLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Action Methods

- (void)call {
    //do some call action
}

#pragma  mark - Helper Methods

- (CALayer *)createBottomLineLayerInView:(UIView *)view {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, view.frame.size.height - 5.f, view.frame.size.width, 5.f);
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    return layer;
}


- (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0f);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

@end
