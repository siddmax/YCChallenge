//
//  YCItem.m
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/6/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import "YCItem.h"

@implementation YCItem

- (instancetype) initWithDictionary:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        self.identity = [data[@"id"] integerValue];
        self.name = data[@"name"];
        self.detail = data[@"description"];
        self.dailyRate = data[@"daily_rate"];
        self.weeklyRate = data[@"weekly_rate"];
        self.monthlyRate = data[@"monthly_rate"];
        self.operatedRates = data[@"operated_rates"];
    }
    
    return self;
}

@end
