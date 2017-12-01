# KRFexibleTableView

>在iOS开发中使用最多的是`UITableView`, 由于实际项目开发中`TableView`界面通常比较复杂，需要在`UITableViewDataSource` `UITableViewDelegate`中写大量的`if else`判断，可读性十分差，而且需求经常修改导致维护困难。KRFexibleTableView对UITableView进行了简单封装，解决上述问题。

## 基本用法

具体见项目中Demo

1. 使用 `KRFexibleTableView`代替`UITableView`

2. 实现 `KRFexibleTableViewDataSource`

3. 在`KRFexibleTableViewDataSource`初始化`KRTableViewChapter` 实现相关方法

## 设计思路

UITableView是由Section 构成，每个Section由若干个UITableViewCell构成，如图所示。

![System TableView -w300](http://p0ac2oojk.bkt.clouddn.com/111.png)

UITabableView通过实现代理方法 UITableViewDataSource UITableViewDelegate 来获取 Section、UITableViewCell，系统的方法很容易写出大量的if else 判断，导致代码逻辑性极差，维护成本极高

```objc
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section == 0) {
        count = 1;
    }else if (section == 1) {
        count = 2;
    } else {
        count = 1;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kKRHeadTableViewCell forIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:kKRBodySmallTableViewCell forIndexPath:indexPath];
        } else {
            cell = [self.tableView dequeueReusableCellWithIdentifier:kKRBodyNormalTableViewCell forIndexPath:indexPath];
        }
    } else {
        cell =  [self.tableView dequeueReusableCellWithIdentifier:kKRFooterTableViewCell forIndexPath:indexPath];
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = 0;
    if (indexPath.section == 0) {
       cellHeight = [KRHeadTableViewCell cellHegith];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 9) {
            cellHeight = [KRBodySmallTableViewCell cellHegith];
        } else {
            cellHeight = [KRBodyNormalTableViewCell cellHegith];
        }
    } else {
        cellHeight = [KRFooterTableViewCell cellHegith];
    }
    
    return cellHeight;
}

```

既然UITableView 抽象的看是由一组Section构成，我们可以把Section 修改一下，最终通过数组来表示UITableView。

封装KRTableViewChapter 对象，比Section更大一些，可以包含若干Section。其中有相关属性如下图所示


![chapter -w300](http://p0ac2oojk.bkt.clouddn.com/22222.png)

```objc
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KRTableViewChapterProtocol

- (NSInteger)numberOfSectionsInChapter;

- (NSInteger)numberOfRowsInSection:(NSNumber *)section sectionIndexInChapter:(NSNumber *)sectionIndexInChapter;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndexInChapter;

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndexInChapter;

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndexInChapter;

@end

@interface KRTableViewChapter : NSObject <KRTableViewChapterProtocol>

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL numberOfSectionsInChapterSEL;

@property (nonatomic, assign) SEL numberOfRowsInSectionSEL;

@property (nonatomic, assign) SEL heightForRowAtIndexPathSEL;

@property (nonatomic, assign) SEL cellForRowAtIndexPathSEL;

@property (nonatomic, assign) SEL didSelectRowAtIndexPathSEL;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)createWithTarget:(id)target;

@end

```

最终UITablView由一组存放KRTableViewChapter的数组描述，这样的好处是可以大量减少if else判断，代码清晰，也便于维护。在App开发中UITableView的改动是非常频繁的。if else多了容易出错。通过数组来进行维护，可以方便的改变顺序，产品让去掉某个cell或者更换的时候非常方便。还可把KRTableViewChapter抽取出来封装成常用的模块，比如分割块等。

![tableview -w300](http://p0ac2oojk.bkt.clouddn.com/3333.png)

最终代码见KRRewirteSystenTablViewController。

