//
//  YCDownloadManager.m
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/5/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import "YCDownloadManager.h"

@implementation YCDownloadManager

NSURLSession* currentSession;

#pragma mark Class Methods

+ (NSURLSession*)currentInstance {
    if (currentSession == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        currentSession = [NSURLSession sessionWithConfiguration:config];
    }
    return currentSession;
}


+ (void)httpGET: (NSString*)urlString withCompletionHandler:(void (^)(NSError* error, NSData *data, NSURLResponse *response))completionBlock {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession* session = [YCDownloadManager currentInstance];
    if (session)
    {
        NSURLSessionDataTask *dataTask =
        [currentSession dataTaskWithURL: url
                      completionHandler:^(NSData *data,
                                          NSURLResponse *response,
                                          NSError *error)
         {
             if(completionBlock != nil)
             {
                 completionBlock(error, data, response);
             }
         }];
        [dataTask resume];
    }
}

@end
