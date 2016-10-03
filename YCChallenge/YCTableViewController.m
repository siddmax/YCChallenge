//
//  YCTableViewController.m
//  YCChallenge
//
//  Created by Siddharth Sharma on 9/5/16.
//  Copyright © 2016 Siddharth Sharma. All rights reserved.
//

#import "YCTableViewController.h"
#import "YCDownloadManager.h"

#define kCustomCell @"customCell"
#define kTableViewTitle @"WHAT KIND OF EQUIPMENT ARE YOU LOOKING FOR?"
#define kNavTitle @"REQUEST EQUIPMENT"
#define kCategoryString @"https://yardclub.github.io/mobile-interview/api/catalog"
#define kSubCategoryString @"https://yardclub.github.io/mobile-interview/api/catalog/"
#define kURLSuffix @".json"

@interface YCTableViewController ()

@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, strong) NSArray *subCategoryArray;
@property (nonatomic, assign) YCTableViewState state;

@end

@implementation YCTableViewController

- (void)viewWillAppear:(BOOL)animated {
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.text = kNavTitle;
    titleView.font = [UIFont boldSystemFontOfSize:15.0];
    titleView.textColor = [UIColor whiteColor];
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"phone"] style:UIBarButtonItemStyleDone target:self action:@selector(call)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    [self downloadCategory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** method to handle if back button will pop controller or just reload table view to category
    from subcategory **/
-(BOOL) navigationShouldPopOnBackButton {
    if(self.state == YCTableViewStateSubCategory) {
        self.state = YCTableViewStateCategory;
        [self.tableView reloadData];
        return NO;
    }
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.state == YCTableViewStateCategory) {
        return self.categoryArray.count;
    } else {
        return self.subCategoryArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCell forIndexPath:indexPath];
    
    // Configuring cell
    if (self.state == YCTableViewStateCategory) {
        NSDictionary *dict = self.categoryArray[indexPath.row];
        cell.textLabel.text = dict[@"name"];
    } else {
        NSDictionary *dict = self.subCategoryArray[indexPath.row];
        cell.textLabel.text = dict[@"display_name"];
    }
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.state == YCTableViewStateCategory) {
        NSDictionary *dict = self.categoryArray[indexPath.row];
        NSInteger categoryID = [dict[@"id"] integerValue];
        [self downloadSubCategory:categoryID];
    } else {
        [self performSegueWithIdentifier:@"detailSegue" sender:self];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = kTableViewTitle;
    label.font = [UIFont boldSystemFontOfSize:12.0];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}

#pragma mark - Target Methods

- (void)call {
    // TODO call action
}

//if you need to pass data to the detail controller do it here
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        //TODO pass a response url
    }
}

#pragma mark - Download Methods

- (void)downloadCategory {
    self.state = YCTableViewStateCategory;
    NSString *categoryURLString = [NSString stringWithFormat:@"%@%@",kCategoryString,kURLSuffix];
    [YCDownloadManager httpGET:categoryURLString withCompletionHandler:^(NSError *error, NSData *data, NSURLResponse *response) {
         if(error) {
             NSLog(@"Failed to get data back -> %@", [error localizedDescription]);
             return;
         }
         
         NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
         if (httpResp.statusCode == 200) {
             NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             
             if (!error) {
                 self.categoryArray = dataArray;
             }
             // Now show the UI, we need to create the views for that
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
             });
         }
     }];
}

- (void)downloadSubCategory:(NSInteger)subCategoryID {
    NSString *subCategoryURLString = [NSString stringWithFormat:@"%@%ld%@",kSubCategoryString,(long)subCategoryID,kURLSuffix];
    [YCDownloadManager httpGET:subCategoryURLString withCompletionHandler:^(NSError *error, NSData *data, NSURLResponse *response) {
        if(error) {
            NSLog(@"Failed to get data back -> %@", [error localizedDescription]);
            return;
        }
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        if (httpResp.statusCode == 200) {
            NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            self.state = YCTableViewStateSubCategory;
            
            if (!error) {
                self.subCategoryArray = dataArray;
            }
            // Now show the UI, we need to create the views for that
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

@end
