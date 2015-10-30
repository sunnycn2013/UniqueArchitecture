# UniqueArchitecture
通用框架 v 1.0

iOS 快速搭建开发框架


## UniqueArchitecture
###UAKit
* ODBC db操作组件
* UABase  VC的重构
* UANetWork 针对AF进一步使用的封装

####  UANetWork 针对AFNetWork进一步使用的封装,UANetWork 在业务层与AF之间增加一个层次，中间用于处理相关的一些承接、处理工作
* UANetWork 网络层的API采用集约式来管理, 相关的请求参数封装在UARequestModel，使用时间只用将对应的requestModel传入UANetWork即可
* UANetWork 内部还对请求common头进行了处理，拼接了设备id、deviceType、size、osversion, 另外还对请求报文参数列表做了签名sign的校验（MD5）
* UANetWork UANetWork提供了两种形式的请求方式：单次任务网络请求(单次可控)、批处理型网络请求(批处理队列型)
* UANetWork 提供了缓存策略型的网络请求方式（UAHttpRequestCacheModel）(AF本身不支持，在AF基础上完善而来)
* UANetWork 封装工作根据业务的需要还处于updating，希望感兴趣的朋友疯狂的pullrequest

##### UANetWork使用介绍

* 单任务类型 UAHttpRequestModel 使用

```objc
//初始化参数列表
NSMutableDictionary *dic = [NSMutableDictionary dictionary];
[dic setObject:@"val1" forKey:@"key1"];

//实例化
UAHttpRequestModel *model = [UAHttpRequestModel model];
model.servicesType = HOST_URL_DEFAULT;
model.servicesName = @"start";
model.params = dic;

//开启活动指示器
[self showNetWorkIndicatorView];
UAHttpRequest *manager = [UAHttpRequest manager];

[manager GET:@"index" parameters:model success:^(UAHttpRequest *request, id responseObject){
NSLog(@"JSON: %@", [request.requestOpetation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);

if (!responseObject) {
return ;
}

NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
NSDictionary *tem = [dic objectForKey:@"weatherinfo"];
NSError *error = nil;
News *new = [MTLJSONAdapter modelOfClass:News.class fromJSONDictionary:tem error:&error];
NSLog(@"refresh : %@",new);
[weakself dismissNetWorkIndicatorView];

} failure:^(UAHttpRequest *request, NSError *error){
NSLog(@"Error: %@", error);

}];

```
* 多任务类型 UAHttpRequestManager 使用

```objc
//初始化参数列表
NSMutableDictionary *dic = [NSMutableDictionary dictionary];
[dic setObject:@"val1" forKey:@"key1"];

//实例化
UAHttpRequestModel *model = [UAHttpRequestModel model];
model.servicesType = HOST_URL_DEFAULT;
model.servicesName = @"start";
model.params = dic;

[self showNetWorkIndicatorView];

UAHttpRequestManager *manager = [UAHttpRequestManager manager];
[manager GET:@"index" parameters:model success:^(AFHTTPRequestOperation *operation, id responseObject) {

NSLog(@"JSON: %@", [operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);

if (!responseObject) {
return ;
}

NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
NSDictionary *tem = [dic objectForKey:@"weatherinfo"];
NSError *error = nil;
News *new = [MTLJSONAdapter modelOfClass:News.class fromJSONDictionary:tem error:&error];
NSLog(@"%@",new);
[weakself dismissNetWorkIndicatorView];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
NSLog(@"Error: %@", error);
}];

[manager GET:@"index1" parameters:model success:^(AFHTTPRequestOperation *operation, id responseObject) {

NSLog(@"JSON1: %@", [operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);

if (!responseObject) {
return ;
}

NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
NSDictionary *tem = [dic objectForKey:@"weatherinfo"];
NSError *error = nil;
News *new = [MTLJSONAdapter modelOfClass:News.class fromJSONDictionary:tem error:&error];
NSLog(@"%@",new);
[weakself dismissNetWorkIndicatorView];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
NSLog(@"Error: %@", error);
}];

```

* 缓存类型 UAHttpRequestCacheModel 使用

```objc

//初始化参数列表
NSMutableDictionary *dic = [NSMutableDictionary dictionary];
[dic setObject:@"val1" forKey:@"key1"];

//实例化
UAHttpRequestCacheModel *model = [UAHttpRequestCacheModel model];
model.servicesType = HOST_URL_DEFAULT;
model.servicesName = @"start";
model.params = dic;
//缓存有效时间
model.leaveTimeout = 500;

[self showNetWorkIndicatorView];

UAHttpRequestCacheManager *manager = [UAHttpRequestCacheManager shareInstance];
[manager GET:@"index" parameters:model success:^(AFHTTPRequestOperation *operation, id responseObject) {

NSLog(@"JSON: %@", [operation.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);

if (!responseObject) {
return ;
}

NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
NSDictionary *tem = [dic objectForKey:@"weatherinfo"];
NSError *error = nil;
News *new = [MTLJSONAdapter modelOfClass:News.class fromJSONDictionary:tem error:&error];
[weakself dismissNetWorkIndicatorView];
[weakself.headRefreshView endRefreshing];

} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
NSLog(@"Error: %@", error);
}];

```


####  ODBC组件介绍使用
* UADB DB的一个单例，主要用于对数据库文件的管理
* UABaseDao  dao层几类，使用时间继承基类，基类里面主要是增、删、改、查对应的操作

备注: ODBC模块的目前主要采用Transaction进行操作，支持多线程并发

```objc
#define HOME_TABLE_NAME @"newsTable"

@interface HomeDao : UABaseDao

//dao层基本四像素操作 model : insert updata delete

/**
 *  插入news
 *
 *  @param news 实例对象
 *
 *  return void
 */
- (void)insertWithNews:(News *)news;

```

```objc
@implementation HomeDao

- (instancetype)init{
    self = [super init];
    
    if (self) {
        //
        self.tableName = HOME_TABLE_NAME;
        self.modelName = @"News";
        [self checkTable];
    }
    return self;
}

/*/*SELECT COUNT(*) FROM sqlite_master where type='table' and name='PackDaoTable';*/

- (void)checkTable{
    NSString *createTable = [NSString stringWithFormat:@"CREATE TABLE if not exists %@ ('id' INTEGER PRIMARY KEY  NOT NULL ,'name' TEXT,'sid' TEXT)", self.tableName];
    [self checkTableAvaiableWithSql:createTable];
}

- (void)insertWithNews:(News *)news{
    NSString *sql = [NSString stringWithFormat:@"insert into %@(name,sid)vaues(%@,%@)",self.tableName,news.city,news.time];
    [self insertWithSql:sql];
}

- (void)updateWithNews:(News *)news andID:(NSString *)Id{
    NSString *sql = [NSString stringWithFormat:@"update %@ set name=%@,sid=%@ where id=%d",self.tableName,news.city,news.time,[Id intValue]];
    [self updateWithSql:sql withArgumentsInArray:nil];
}

- (void)deleteNewsWithId:(NSString *)Id{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where id=%d",self.tableName,[Id intValue]];
    [self deleteWithSql:sql andDictionary:nil];
}

```
