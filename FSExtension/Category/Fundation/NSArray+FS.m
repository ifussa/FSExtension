//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "NSArray+FS.h"
#import <objc/runtime.h>
#import "NSObject+FS.h"

@implementation NSArray (FS)

#pragma mark - 防止越界
+ (void)load {
    [super load];
    //无论怎样 都要保证方法只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //交换NSArray中的objectAtIndex方法
        [objc_getClass("__NSArrayI") fs_systemSelector:@selector(objectAtIndex:) swizzledSelector:@selector(s_objectAtIndex:) error:nil];
        //交换NSArray中的objectAtIndexedSubscript方法
        [objc_getClass("__NSArrayI") fs_systemSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(s_objectAtIndexedSubscript:) error:nil];
    });
}

- (id)s_objectAtIndexedSubscript:(NSUInteger)index {
    if (index < self.count) {
        return [self s_objectAtIndexedSubscript:index];
    } else {
        NSLog(@"数组越界, 已处理: %ld, %ld, %@", index, self.count, [self class]);
        return nil;
    }
}

- (id)s_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self s_objectAtIndex:index];
    } else {
        NSLog(@"数组越界, 已处理: %ld, %ld, %@", index, self.count, [self class]);
        return nil;
    }
}



+ (NSArray *)fs_arrayFromJSONString:(NSString *)string {
    if (!string) {
        return nil;
    }

    NSError *error;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:&error];

    if (error || !object) {
        return nil;
    }

    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    } else if ([object isKindOfClass:[NSString class]]
            || [object isKindOfClass:[NSDictionary class]]) {
        return @[object];
    } else {
        return nil;
    }
}

- (id)fs_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return self[index];
}

@end

@implementation NSMutableArray (FS)


+ (void)load {
    [super load];
    //无论怎样 都要保证方法只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //交换NSMutableArray中的方法
        [objc_getClass("__NSArrayM") fs_systemSelector:@selector(objectAtIndex:) swizzledSelector:@selector(s_objectAtIndex:) error:nil];
        //交换NSMutableArray中的方法
        [objc_getClass("__NSArrayM") fs_systemSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(s_objectAtIndexedSubscript:) error:nil];
    });
}

- (id)s_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self s_objectAtIndex:index];
    } else {
        NSLog(@"数组越界, 已处理: %ld, %ld, %@", index, self.count, [self class]);
        return nil;
    }
}

- (id)s_objectAtIndexedSubscript:(NSUInteger)index {
    if (index < self.count) {
        return [self s_objectAtIndexedSubscript:index];
    } else {
        NSLog(@"数组越界, 已处理: %ld, %ld, %@", index, self.count, [self class]);
        return nil;
    }
}


- (void)fs_addObject:(id)object {
    if (object) {
        [self addObject:object];
    }
}

- (bool)fs_insertObject:(id)object atIndex:(NSUInteger)index {
    if (index >= self.count && index != 0) {
        return NO;
    }

    if (!object) {
        return NO;
    }

    [self insertObject:object atIndex:index];

    return YES;
}

- (bool)fs_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return NO;
    }
    [self removeObjectAtIndex:index];
    return YES;

}

- (bool)fs_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    if (index >= self.count) {
        return NO;
    }
    self[index] = object;
    return YES;
}

+ (NSMutableArray *)fs_sortByKey:(NSString *)key array:(NSMutableArray *)array ascending:(BOOL)ascending {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    [tempArray addObjectsFromArray:array];

    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortDescriptors = @[brandDescriptor];
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:sortDescriptors];
    [tempArray removeAllObjects];
    tempArray = (NSMutableArray *) sortedArray;
    [array removeAllObjects];
    [array addObjectsFromArray:tempArray];

    return array;
}

@end


@implementation NSArray (FS_FP)

- (NSArray *)fs_filterRepeat {
    NSSet *set = [NSSet setWithArray:self];
    NSArray *result = [set allObjects];
    return result;
}

- (void)fs_forEach:(void (^)(id, NSUInteger))block {
    if (!block) {
        return;
    }
    for (id element in self) {
        block(element, [self indexOfObject:element]);
    }
}

- (NSArray *)fs_map:(id (^)(id, NSUInteger))block {
    NSMutableArray *newArray = [NSMutableArray array];
    if (!block) {
        return self;
    }
    for (id element in self) {
        [newArray addObject:block(element, [self indexOfObject:element])];
    }
    return newArray;
}

- (NSMutableArray *)fs_mutableMap:(id (^)(id, NSUInteger))block {
    NSMutableArray *newArray = [NSMutableArray array];
    if (!block) {
        return self.mutableCopy;
    }
    for (id element in self) {
        [newArray addObject:block(element, [self indexOfObject:element])];
    }
    return newArray;
}

- (NSArray *)fs_flatMap:(id (^)(id, NSUInteger))block {
    NSMutableArray *newArr = [NSMutableArray array];
    if (!block) {
        return self;
    }
    return [self fs_reduceWithInitialResult:newArr nextPartialResult:^id(id result, id element, NSUInteger index) {
        if ([element isKindOfClass:[NSArray class]]) {
            __kindof NSArray *arr = element;
            [result addObjectsFromArray:[arr fs_map:^id(id aElement, NSUInteger aIndex) {
                return block(aElement, aIndex);
            }]];
        } else {
            [result addObject:block(element, index)];
        }
        return result;
    }];
}

- (id)fs_filterFirst:(BOOL (^)(id, NSUInteger))block {
    if (!block) {
        return nil;
    }
    for (id element in self) {
        if (block(element, [self indexOfObject:element])) {
            return element;
        }
    }
    return nil;
}

- (NSArray *)fs_filter:(BOOL (^)(id, NSUInteger))block {
    NSMutableArray *newArray = [NSMutableArray array];
    if (!block) {
        return self;
    }
    for (id element in self) {
        if (block(element, [self indexOfObject:element])) {
            [newArray addObject:element];
        }
    }
    return newArray;
}

- (NSArray *)fs_sort:(NSComparisonResult (^)(id, id))block {
    return [self sortedArrayUsingComparator:block];
}

- (NSArray *)fs_sortAscending:(NSNumber *(^)(id))block {
    return [self fs_sort:^NSComparisonResult(id obj1, id obj2) {
        if (![block(obj1) isKindOfClass:[NSNumber class]]) {
            return NSOrderedSame;
        }
        return (NSComparisonResult) ([block(obj1) compare:block(obj2)] == NSOrderedDescending);
    }];
}

- (NSArray *)fs_sortDescending:(NSNumber *(^)(id))block {
    return [self fs_sort:^NSComparisonResult(id obj1, id obj2) {
        if (![block(obj1) isKindOfClass:[NSNumber class]]) {
            return NSOrderedSame;
        }
        return (NSComparisonResult) ([block(obj1) compare:block(obj2)] == NSOrderedAscending);
    }];
}


- (id)fs_max:(NSNumber *(^)(id, NSUInteger))block {
    if (!self.count) {
        return nil;
    }
    __block NSNumber *max = block(self.firstObject, 0);
    __block NSUInteger maxIndex = 0;
    [self fs_forEach:^(id element, NSUInteger index) {
        NSNumber *number = block(element, index);
        if ([max compare:number] == NSOrderedAscending) {
            maxIndex = index;
            max = number;
        }
    }];
    return self[maxIndex];
}

- (id)fs_min:(NSNumber *(^)(id, NSUInteger))block {
    if (!self.count) {
        return nil;
    }
    __block NSNumber *min = block(self.firstObject, 0);
    __block NSUInteger minIndex = 0;
    [self fs_forEach:^(id element, NSUInteger index) {
        NSNumber *number = block(element, index);
        if ([min compare:number] == NSOrderedDescending) {
            minIndex = index;
            min = number;
        }
    }];
    return self[minIndex];
}

- (id)fs_reduceWithInitialResult:(id)initialResult nextPartialResult:(id (^)(id, id, NSUInteger))nextPartialResult {
    id result = initialResult;
    for (id element in self) {
        result = nextPartialResult(result, element, [self indexOfObject:element]);
    }
    return result;
}

- (NSArray *)fs_dropFirst {
    if (self.count == 0 || self.count == 1) {
        return @[];
    }
    return [self subarrayWithRange:NSMakeRange(1, self.count - 1)];
}

- (NSArray *)fs_removeObjectOfClass:(Class)className {
    if (self.count == 0) {
        return @[];
    }
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [self fs_forEach:^(id element, NSUInteger index) {
        if ([element isKindOfClass:className]) {
            [indexSet addIndex:index];
        }
    }];
    NSMutableArray *array = [self mutableCopy];
    [array removeObjectsAtIndexes:indexSet];
    return array;
}

@end
