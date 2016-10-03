//
//  YCDetailViewController.m
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/6/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import "YCDetailViewController.h"
#import "YCItem.h"
#import "YCDownloadManager.h"
#import "UIImage+animatedGIF.h"
#import "YCDetailItemCollectionViewCell.h"
#import "YCDetailPhotoCollectionViewCell.h"

#define kResultJSON @"https://yardclub.github.io/mobile-interview/api/results.json"
#define kItemCell @"itemCell"
#define kPhotoCell @"photoCell"

@interface YCDetailViewController ()

@property (nonatomic, strong) NSArray<YCItem*> *items;
@property (nonatomic, strong) NSArray<UIImage*> *photos;

@end

@implementation YCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemCollectionView.delegate = self;
    self.photoCollectionView.delegate = self;
    
    self.itemCollectionView.dataSource = self;
    self.photoCollectionView.dataSource = self;
    
    [self downloadResultJSON];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.itemCollectionView) {
        return self.items.count;
    } else {
        return self.photos.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.itemCollectionView) {
        YCDetailItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kItemCell forIndexPath:indexPath];
        
        YCItem *item = self.items[indexPath.row];
        cell.nameLabel.text = item.name;
        cell.descriptionLabel.text = item.detail;
        cell.dailyRateLabel.text = item.dailyRate;
        cell.weeklyRateLabel.text = item.weeklyRate;
        cell.monthlyRateLabel.text = item.monthlyRate;
        cell.operatedRatesLabel.text = item.operatedRates;
        
        return cell;
    } else {
        YCDetailPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCell forIndexPath:indexPath];
        cell.photo.image = self.photos[indexPath.row];
        
        return cell;
    }
}

#pragma mark - Download Methods

- (void)downloadResultJSON {
    [YCDownloadManager httpGET:kResultJSON withCompletionHandler:^(NSError *error, NSData *data, NSURLResponse *response) {
        if(error) {
            NSLog(@"Failed to get data back -> %@", [error localizedDescription]);
            return;
        }
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        if (httpResp.statusCode == 200) {
            NSDictionary *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (!error) {
                self.items = [self getItemArray:dataArray[@"results"]];
                self.photos = [self getPhotoArray:dataArray[@"featured_photos"]];
            }
            // Now show the UI, we need to create the views for that
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.itemCollectionView reloadData];
                [self.photoCollectionView reloadData];
            });
        }
    }];
}

- (NSArray<YCItem*> *)getItemArray:(NSArray *)array{
    NSMutableArray<YCItem *> *mutableArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary *data in array) {
        YCItem *item = [[YCItem alloc] initWithDictionary:data];
        [mutableArray addObject:item];
    }
    
    return mutableArray;
}

- (NSArray<UIImage*> *)getPhotoArray:(NSArray *)array{
    NSMutableArray<UIImage *> *mutableArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary *data in array) {
        NSString *urlString = data[@"url"];
        NSURL *url = [NSURL URLWithString:urlString];
        UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:url];
        [mutableArray addObject:image];
    }
    
    return mutableArray;
}

@end
