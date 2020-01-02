//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FS)

/**
 * JSON 字符串转数组
 */
+ (NSArray *)fs_arrayFromJSONString:(NSString *)string;

- (id)fs_objectAtIndex:(NSUInteger)index;

/// 数组替换元素
- (NSArray *)fs_replace:(id)object atIndex:(NSInteger)index;
@end

@interface NSMutableArray (FS)

- (void)fs_addObject:(id)object;

- (bool)fs_insertObject:(id)object atIndex:(NSUInteger)index;

- (bool)fs_removeObjectAtIndex:(NSUInteger)index;

- (bool)fs_replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;

/// 排序
+ (NSMutableArray *)fs_sortByKey:(NSString *)key array:(NSMutableArray *)array ascending:(BOOL)ascending;
@end



@interface NSArray<ObjectType> (FS_FP)

#pragma mark - 遍历

/**
 * 数组遍历
 */
- (void)fs_forEach:(void (NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

/**
 * 数组遍历, 返回不可变数据
 */
- (NSArray *)fs_map:(id(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

/**
 * 数组遍历, 返回可变数据
 */
- (NSMutableArray *)fs_mutableMap:(id(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

/**
 * 数组展开 element的类型是数组元素的元素类型
 */
- (NSArray *)fs_flatMap:(id(NS_NOESCAPE ^)(id element, NSUInteger index))block;

#pragma mark - 筛选

/**
 * 数据筛选
 */
- (NSArray<ObjectType> *)fs_filter:(BOOL(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

/**
 * 获取第一个符合的元素
 */
- (ObjectType)fs_filterFirst:(BOOL(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;

#pragma mark - 去重

/**
 * 去除重复元素
 */
- (NSArray<ObjectType> *)fs_filterRepeat;

#pragma mark - 排序

/**
 * 数组排序
 */
- (NSArray<ObjectType> *)fs_sort:(NSComparisonResult (^)(ObjectType obj1, ObjectType obj2))block;

/**
 * 数组排序(降序)
 */
- (NSArray<ObjectType> *)fs_sortAscending:(NSNumber *(^)(ObjectType element))block;

/**
 * 数组排序(升序)
 */
- (NSArray<ObjectType> *)fs_sortDescending:(NSNumber *(^)(ObjectType element))block;

/**
 * 获取最大值
 */
- (ObjectType)fs_max:(NSNumber *(^)(ObjectType element))block;

/**
 * 获取最小值
 */
- (ObjectType)fs_min:(NSNumber *(^)(ObjectType element))block;

/**
 * 累加函数
 */
- (ObjectType)fs_reduceWithInitialResult:(id)initialResult nextPartialResult:(id (^)(id result, ObjectType element, NSUInteger index))nextPartialResult;

#pragma mark - 移除

/**
 * 移除第一个
 */
- (NSArray<ObjectType> *)fs_dropFirst;

/**
 * 移除某种类型的元素
 */
- (NSArray<ObjectType> *)fs_removeObjectOfClass:(Class)className;


#pragma mark - 替换
- (NSArray<ObjectType> *)fs_replaceAtIndex:(NSInteger)index block: (id(NS_NOESCAPE ^)(ObjectType element, NSUInteger index))block;
@end

