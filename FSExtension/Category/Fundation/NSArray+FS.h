//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FS)

#pragma mark - 安全操作
- (id)fs_safeObjectAtIndex:(NSUInteger)index;

@end


@interface NSMutableArray (FS)

#pragma mark - 安全操作


-(void)fs_safeAddObject:(id)anObject;
-(bool)fs_safeInsertObject:(id)anObject atIndex:(NSUInteger)index;
-(bool)fs_safeRemoveObjectAtIndex:(NSUInteger)index;
-(bool)fs_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/*!
 *  排序
 */
+ (NSMutableArray *)fs_sortArrayByKey:(NSString *)key
                             array:(NSMutableArray *)array
                         ascending:(BOOL)ascending;
@end
