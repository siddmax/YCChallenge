//
//  YCDownloadManager.h
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/5/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCDownloadManager : NSObject

+(void)httpGET:(NSString*)urlString withCompletionHandler:(void (^)(NSError* error, NSData *data, NSURLResponse *response))completionBlock;

@end
