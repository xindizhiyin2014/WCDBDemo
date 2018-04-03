//
//  TestModel+WCTTableCoding.h
//  WCDBDemo
//
//  Created by JackLee on 2018/4/3.
//  Copyright © 2018年 JackLee. All rights reserved.
//

#import "TestModel.h"
#import <WCDB/WCDB.h>

@interface TestModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(name)
WCDB_PROPERTY(modelID)


@end
