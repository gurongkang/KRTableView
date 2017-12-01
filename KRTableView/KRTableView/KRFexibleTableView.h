//
//  KRFexibleTableView.h
//  KRFexibleTableView
//
//  Created by RK on 2017/11/28.
//  Copyright © 2017年 KR. All rights reserved.

#import <UIKit/UIKit.h>
#import "KRTableViewChapter.h"

@protocol KRFexibleTableViewDataSource<NSObject>

- (NSArray *)kr_fexibleTableViewChapters;

@end

@interface KRFexibleTableView : UITableView

@property (nonatomic, weak) id <KRFexibleTableViewDataSource> fexibleTableViewDataSource;

@end
