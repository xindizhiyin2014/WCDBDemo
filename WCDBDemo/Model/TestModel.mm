//
//  TestModel.mm
//  WCDBDemo
//
//  Created by JackLee on 2018/4/3.
//  Copyright © 2018年 JackLee. All rights reserved.
//

#import "TestModel+WCTTableCoding.h"
#import "TestModel.h"
#import <WCDB/WCDB.h>

@implementation TestModel

WCDB_IMPLEMENTATION(TestModel)
WCDB_SYNTHESIZE(TestModel, name)
WCDB_SYNTHESIZE(TestModel, modelID)


WCDB_PRIMARY(TestModel, modelID)

//WCDB_INDEX(TestModel, "_index", modelID)

@end
