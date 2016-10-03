//
//  YCTableViewCell.m
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/5/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import "YCTableViewCell.h"

@implementation YCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right"]];
}

@end
