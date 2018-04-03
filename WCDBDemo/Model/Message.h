//
//  Message.h
//  WCDBDemo
//
//  Created by JackLee on 2018/3/31.
//  Copyright © 2018年 JackLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property(nonatomic, assign) NSInteger localID;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, strong) NSDate *createTime;
@property(nonatomic, strong) NSDate *modifiedTime;
@property(nonatomic, assign) NSInteger age;


@end
