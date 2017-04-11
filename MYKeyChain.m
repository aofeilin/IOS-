//
//  MYKeyChain.m
//  MS
//
//  Created by ule_zhangfanglin on 2017/4/11.
//  Copyright © 2017年 admin. All rights reserved.
//
/*
 secitemAdd 增
 secitemDelete 删除
 secitemUpdate 改
 secitemCopymatching 查
 */

#import "MYKeyChain.h"
//设置key
#define  MYKEYCHAIN     @"com.keychain.idfa"
#define  MYKEYCHAINDIC  @"com.keychain.iddic"
@implementation MYKeyChain


//Get search dictionary
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}



/*增加  保存*/
+(void)myKeyChainSave:(NSString *)string
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:string forKey:MYKEYCHAIN];
    [self save:MYKEYCHAINDIC data:tempDic];
}
/*删除 delete*/
+(void)myKeyChainDelete:(NSString *)string
{
     [self delete:MYKEYCHAINDIC];
}
/*查询 load secitemCopymatching*/
+(NSString *)myKeyChainLoad
{
    NSMutableDictionary * tempDic =(NSMutableDictionary *)[self load:MYKEYCHAINDIC];
    return [tempDic objectForKey:MYKEYCHAIN];
}




/**
  1增加 add  save
 */
+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

/**
  2查询 secitemCopymatching 查
 */

+ (id)load:(NSString *)service
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id<NSCopying>)(kSecReturnData)];
    [keychainQuery setObject:(__bridge id)(kSecMatchLimitOne) forKey:(__bridge id<NSCopying>)(kSecMatchLimit)];
    
    CFTypeRef result = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, &result) == noErr)
    {
        ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)result];
    }
    return ret;
}


/**
  3删除  delete
 */
+ (void)delete:(NSString *)service
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)(keychainQuery));
}






@end
