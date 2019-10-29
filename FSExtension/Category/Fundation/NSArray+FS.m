//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "NSArray+FS.h"


@implementation NSArray (FS)
- (id)fs_safeObjectAtIndex:(NSUInteger)index {
    if ( index >= self.count ){
        return nil;
    }
    return self[index];
}

@end

@implementation NSMutableArray (FS)


- (void)fs_safeAddObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

-(bool)fs_safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if ( index >= self.count && index != 0) {
        return NO;
    }

    if (!anObject) {
        return NO;
    }

    [self insertObject:anObject atIndex:index];

    return YES;
}

-(bool)fs_safeRemoveObjectAtIndex:(NSUInteger)index {
    if ( index >= self.count ) {
        return NO;
    }
    [self removeObjectAtIndex:index];
    return YES;

}

-(bool)fs_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if ( index >= self.count ) {
        return NO;
    }
    self[index] = anObject;
    return YES;
}

+ (NSMutableArray *)fs_sortArrayByKey:(NSString *)key array:(NSMutableArray *)array ascending:(BOOL)ascending {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray removeAllObjects];
    [tempArray addObjectsFromArray:array];

    NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:ascending];
    NSArray *sortDescriptors = @[brandDescriptor];
    NSArray *sortedArray = [tempArray sortedArrayUsingDescriptors:sortDescriptors];
    [tempArray removeAllObjects];
    tempArray = (NSMutableArray *)sortedArray;
    [array removeAllObjects];
    [array addObjectsFromArray:tempArray];

    return array;
}

@end