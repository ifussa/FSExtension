//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "NSDictionary+FS.h"


@implementation NSDictionary (FS)

-(NSData*)fsdata {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

- (NSString *)fs_dictionaryToJson {
    return [NSDictionary fs_dictionaryToJson:self];
}

+ (NSString *)fs_dictionaryToJson:(NSDictionary *)dictionary {
    NSString *json     = nil;
    NSError  *error    = nil;
    NSData   *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];

    if (!jsonData) {
        return @"{}";
    } else if (!error) {
        json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    } else {
        return error.localizedDescription;
    }
}

@end

@implementation NSMutableDictionary (FS)

- (void)fs_safeSetObject:(id)anObject forKey:(id < NSCopying >)aKey {
    if (!anObject || !aKey) {
        return;
    }
    self[aKey] = anObject;
}

- (void)fs_safeRemoveObjectForKey:(id)aKey {
    if(!aKey) {
        return;
    }
    [self removeObjectForKey:aKey];
}

@end
