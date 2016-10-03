//
//  YCItem.h
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/6/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCItem : NSObject

- (instancetype) initWithDictionary:(NSDictionary *)data;

@property (nonatomic, assign) NSInteger identity;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *dailyRate;
@property (nonatomic, strong) NSString *weeklyRate;
@property (nonatomic, strong) NSString *monthlyRate;
@property (nonatomic, strong) NSString *operatedRates;

@end
