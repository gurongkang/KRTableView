# KRFexibleTableView

>在iOS开发中使用最多的是`UITableView`, 由于实际项目开发中`TableView`界面通常比较复杂，需要在`UITableViewDataSource` `UITableViewDelegate`中写大量的`if else`判断，可读性十分差，而且需求经常修改导致维护困难。KRFexibleTableView对UITableView进行了简单封装，解决上述问题。

## 使用

具体见项目中Demo

1. 使用 `KRFexibleTableView`代替`UITableView`

2. 实现 `KRFexibleTableViewDataSource`

3. 在`KRFexibleTableViewDataSource`初始化`KRTableViewChapter` 实现相关方法
