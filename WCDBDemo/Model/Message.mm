//
//  Message.mm
//  WCDBDemo
//
//  Created by JackLee on 2018/3/31.
//  Copyright © 2018年 JackLee. All rights reserved.
//

#import "Message+WCTTableCoding.h"
#import "Message.h"
#import <WCDB/WCDB.h>

@implementation Message

WCDB_IMPLEMENTATION(Message)
WCDB_SYNTHESIZE(Message, localID)
WCDB_SYNTHESIZE(Message, content)
WCDB_SYNTHESIZE(Message, createTime)
WCDB_SYNTHESIZE(Message, modifiedTime)
WCDB_SYNTHESIZE(Message, age)


WCDB_PRIMARY(Message, localID)

WCDB_INDEX(Message, "_index", createTime)
  
@end
