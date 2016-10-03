//
//  YCDetailViewController.h
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/6/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCDetailItemCollectionView.h"
#import "YCDetailPhotoCollectionView.h"

@interface YCDetailViewController : UIViewController  <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet YCDetailItemCollectionView *itemCollectionView;
@property (weak, nonatomic) IBOutlet YCDetailPhotoCollectionView *photoCollectionView;


@end
