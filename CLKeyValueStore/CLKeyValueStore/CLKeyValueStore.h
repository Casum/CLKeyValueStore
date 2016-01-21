//
//  CLKeyValueStore.h
//  CLFramework
//
//  Created by Casum Leung on 15/10/22.
//  Copyright © 2015年 Casum. All rights reserved.
//

/*
 *CLKeyValueStore是对TMCache进行了封装，目的是使App具有像sqlite一样分区间存储数据，只适合保存数据量小的App使用
 */

#import <Foundation/Foundation.h>

#define CACHE_OBJ(key,space) [[CLKeyValueStore sharedInstance] getObjectByKey:key fromSpace:space];
#define SET_CACHEOBJ(value,key,space) [[CLKeyValueStore sharedInstance] setObject:value withKey:key intoSpace:space];

@interface CLKeyValueStore : NSObject

+ (nullable instancetype)sharedInstance;

- (void)setObject:(nonnull id <NSCoding>)object withKey:(nonnull NSString *)key intoSpace:(nonnull NSString*)spaceName;

- (nullable id)getObjectByKey:(nonnull NSString *)key fromSpace:(nonnull NSString *)spaceName;

- (nullable NSDictionary *)getAllItemsFromSpace:(nonnull NSString *)spaceName;

- (void)deleteObjectByKey:(nullable NSString *)key fromSpace:(nullable NSString *)spaceName;

- (void)deleteObjectsByKeyArray:(nullable NSArray *)keyArray fromSpace:(nullable NSString *)spaceName;

- (void)deleteAllObjectsFormSpace:(nullable NSString *)spaceName;

@end
