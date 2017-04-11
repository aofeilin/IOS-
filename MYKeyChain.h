//
//  MYKeyChain.h
//  MS
//
//  Created by ule_zhangfanglin on 2017/4/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYKeyChain : NSObject
//增删查
/*增加  保存*/
+(void)myKeyChainSave:(NSString *)string;
/*删除 delete*/
+(void)myKeyChainDelete:(NSString *)string;
/*查询 load secitemCopymatching*/
+(NSString *)myKeyChainLoad;

@end
