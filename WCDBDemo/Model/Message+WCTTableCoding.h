//
//  Message+WCTTableCoding.h
//  WCDBDemo
//
//  Created by JackLee on 2018/3/31.
//  Copyright © 2018年 JackLee. All rights reserved.
//

#import "Message.h"
#import <WCDB/WCDB.h>

@interface Message (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(localID)
WCDB_PROPERTY(content)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)

@end
