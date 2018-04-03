//
//  ViewController.m
//  WCDBDemo
//
//  Created by JackLee on 2018/3/31.
//  Copyright © 2018年 JackLee. All rights reserved.
//

#import "ViewController.h"
#import "Message+WCTTableCoding.h"
#import "TestModel+WCTTableCoding.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic,strong) WCTDatabase *database;
@property (nonatomic,assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self contentTableView];
    self.count = 0;
}

#pragma mark - lazyLoad
- (NSArray *)dataArray{
    if(!_dataArray){
        _dataArray = @[@"创建数据库",@"创建Message表",@"插入数据",@"删除数据",@"修改数据",@"查询数据",@"数据加密",@"验证线程安全",@"删除table",@"添加列",@"根据需要创建表"];
    }
    return _dataArray;
}

- (UITableView *)contentTableView{
    if(!_contentTableView){
        _contentTableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _contentTableView.dataSource =self;
        _contentTableView.delegate = self;
        [_contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_contentTableView];
    }
    return _contentTableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self createDataBase];
        }
            break;
        case 1:
        {
            [self createTable];
        }
            break;
        case 2:
        {
            [self inserDataToDB];
        }
            break;
        case 3:
        {
            [self deleteDataToDB];
        }
            break;
        case 4:
        {
            [self updateDataToDB];
        }
            break;
        case 5:
        {
            [self searchDataFromData];
        }
            break;
        case 6:
        {
            [self encryptDBData];
        }
            break;
        case 7:
        {
            [self checkThreadSafe];
        }
            break;
        case 8:
        {
            [self deleteTable];
        }
            break;
        case 9:
        {
            [self addTableColumn];
        }
            break;
        case 10:
        {
            [self createTableViewCondition];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - - - -  创建数据库 - - - -
- (WCTDatabase *)createDataBase{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [NSString stringWithFormat:@"%@/testDB.sqlite",docDir];
    NSLog(@"DB Path %@",path);
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    return database;
}

- (void)createTable{
    /*
     CREATE TABLE messsage (localID INTEGER PRIMARY KEY,
     content TEXT,
     createTime BLOB,
     modifiedTime BLOB)
     */
    BOOL result = [self.database createTableAndIndexesOfName:@"message"
                                              withClass:Message.class];
    
}

#pragma mark - - - - 数据库中插入数据 - - - -
- (void)inserDataToDB{
    self.count++;
    //插入
    Message *message = [[Message alloc] init];
    message.localID = self.count;
    message.content = @"Hello, WCDB!";
    message.createTime = [NSDate date];
    message.modifiedTime = [NSDate date];
    /*
     INSERT INTO message(localID, content, createTime, modifiedTime)
     VALUES(1, "Hello, WCDB!", 1496396165, 1496396165);
     */
    BOOL result = [self.database insertObject:message into:@"message"];
}

#pragma mark - - - - 从数据中删除数据 - - - -
- (void)deleteDataToDB{
    
    BOOL result = [self.database deleteObjectsFromTable:@"message"
                                                  where:Message.localID > 0];
}

#pragma mark - - - - 更新数据 - - - -
- (void)updateDataToDB{
    Message *message = [[Message alloc] init];
    message.content = @"Hi jack!";
    
    BOOL result = [self.database updateAllRowsInTable:@"message"
                                         onProperties:Message.content
                                           withObject:message];
}

#pragma mark - - - - 查询数据 - - - -
- (void)searchDataFromData{
    //查询
    //SELECT * FROM message ORDER BY localID
    NSArray<Message *> *messages = [self.database getObjectsOfClass:Message.class
                                                          fromTable:@"message"
                                                            orderBy:Message.localID.order()];
    
    
    //第二种查询方法
    //    WCTTable *table = [self.database getTableOfName:@"message"
    //                                     withClass:Message.class];
    //    //查询
    //    //SELECT * FROM message ORDER BY localID
    //    NSArray<Message *> *message = [table getObjectsOrderBy:Message.localID.order()];
    
}

#pragma mark - - - - 加密数据 - - - -
- (void)encryptDBData{
    NSData *password = [@"MyPassword" dataUsingEncoding:NSASCIIStringEncoding];
    [self.database setCipherKey:password];
}

#pragma mark - - - - 验证是否线程安全 - - - -
- (void)checkThreadSafe{
    _database=nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createDataBase];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self searchDataFromData];
        });
    });
    
}

#pragma mark - - - - 删除表
- (void)deleteTable{
    [self.database dropTableOfName:@"message"];
}

#pragma mark - - - - 添加列 - - - -
- (void)addTableColumn{
    [self.database addColumn:Message.age.def(WCTColumnTypeInteger64) forTable:@"message"];
}

#pragma mark - - - - 根据需要创建表 - - - -
- (void)createTableViewCondition{
    
    [self.database createTableOfName:@"TestModel" withColumnDefList:{TestModel.modelID.def(WCTColumnTypeInteger64)}];
    NSString *indexSubfix = @"_index";
    NSString *indexName = [@"TestModel" stringByAppendingString:indexSubfix];
    [self.database createIndexOfName:@"TestModel_index" withIndexList:{TestModel.modelID.index()} forTable:@"TestModel"];
    
}

#pragma mark - - - - lazyLoad - - - -
- (WCTDatabase *)database{
    if (!_database) {
        _database = [self createDataBase];
    }
    return _database;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

