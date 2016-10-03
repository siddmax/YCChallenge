//
//  YCDetailItemCollectionViewCell.h
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/6/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCDetailItemCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dailyRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weeklyRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatedRatesLabel;


@end
