//
//  YCTableViewController.h
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/5/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YCTableViewState) {
    YCTableViewStateCategory,
    YCTableViewStateSubCategory
};

@interface YCTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@end
