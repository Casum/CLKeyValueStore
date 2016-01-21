//
//  CLKeyValueStore.m
//  CLFramework
//
//  Created by Casum Leung on 15/10/22.
//  Copyright © 2015年 Casum. All rights reserved.
//

#import "CLKeyValueStore.h"
#import "TMCache.h"

#ifdef DEBUG
#define debugLog(...)    NSLog(__VA_ARGS__)
#else
#define debugLog(...)
#endif

@implementation CLKeyValueStore

+ (nullable instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static CLKeyValueStore * sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CLKeyValueStore alloc]init];
    });
    return sharedInstance;
}

- (void)setObject:(nonnull id <NSCoding>)object withKey:(nonnull NSString *)key intoSpace:(nonnull NSString*)spaceName{
    if (spaceName.length == 0 || key.length == 0) {
        return;
    }
    
    NSMutableDictionary *spaceData = [NSMutableDictionary dictionaryWithDictionary:[self getAllItemsFromSpace:spaceName]];
    if (!spaceData) spaceData = [NSMutableDictionary new];
    if ([spaceData isKindOfClass:[NSDictionary class]]) {
        spaceData[key] = object;
        [[TMCache sharedCache] setObject:spaceData forKey:spaceName];
        
        [self normalLog:[NSString stringWithFormat:@"SetCache Success -->key: %@ space:%@",key,spaceName]];
    }else{
        [self warnLog:@"SetCache Fail" desc:@"SpaceName : %@ data error!"];
    }
}

- (nullable id)getObjectByKey:(nonnull NSString *)key fromSpace:(nonnull NSString *)spaceName{
    id result = nil;
    if (spaceName.length > 0 && key.length > 0) {
        NSDictionary *spaceData = [self getAllItemsFromSpace:spaceName];
        result = spaceData[key];
    }
    return result;
}

- (nullable NSDictionary *)getAllItemsFromSpace:(nonnull NSString *)spaceName{
    return [[TMCache sharedCache] objectForKey:spaceName];
}

- (void)deleteObjectByKey:(nullable NSString *)key fromSpace:(nullable NSString *)spaceName{
    if (spaceName.length || key.length == 0) {
        return;
    }
    NSMutableDictionary *spaceData = [NSMutableDictionary dictionaryWithDictionary:[self getAllItemsFromSpace:spaceName]];
    if ([spaceData isKindOfClass:[NSDictionary class]]) {
        if (spaceData.allKeys > 0) {
            [spaceData removeObjectForKey:key];
            [[TMCache sharedCache] setObject:spaceData forKey:spaceName];
            [self normalLog:[NSString stringWithFormat:@"DeleteCache Success -->key: %@ space:%@",key,spaceName]];
        }
    }
}

- (void)deleteObjectsByKeyArray:(nullable NSArray *)keyArray fromSpace:(nullable NSString *)spaceName{
    for (NSString *key in keyArray) {
        [self deleteObjectByKey:key fromSpace:spaceName];
    }
}

- (void)deleteAllObjectsFormSpace:(nullable NSString *)spaceName{
    [[TMCache sharedCache] removeObjectForKey:spaceName];
}

- (void)normalLog:(NSString*)log{
    debugLog(@"###   %@   ###",log);
}

- (void)warnLog:(NSString*)title desc:(NSString*)desc{
    debugLog(@"###   %@   ###\n--->Reson:%@",title,desc);
}

@end
