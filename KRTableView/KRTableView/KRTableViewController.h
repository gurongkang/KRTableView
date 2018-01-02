//
//  KRTableViewController.h
//  KRTableView
//
//  Created by RK on 2018/1/2.
//  Copyright © 2018年 KR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRFexibleTableView.h"

@interface KRTableViewController : UIViewController

@property (nonatomic, strong) KRFexibleTableView *tableView;
@property (nonatomic, strong) KRTableViewChapter *splitSection;

/**
 分割
 
 @return cell
 */
- (UITableViewCell *)cellForSeperator;

/**
 注册TableViewCell
 */
- (void)registerTableViewCell;

@end
