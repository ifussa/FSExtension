//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Directory type enum
 */
typedef NS_ENUM(NSInteger, FSDirectoryType)
{
    FSDirectoryTypeMainBundle = 0,
    FSDirectoryTypeLibrary,
    FSDirectoryTypeDocuments,
    FSDirectoryTypeCache
};

@interface NSFileManager (FS)


/**
 *  读取某个文件,返回字符串
 *
 *  @param file 文件名
 *  @param type 文件类型
 *  @return 返回内容是一个字符串
 */
+ (NSString *)fs_readTextFile:(NSString *)file
                       ofType:(NSString *)type;

+ (NSString *)fs_getBundlePathForFile:(NSString *)fileName;

/**
 *获取Documents下文件路径
 */
+ (NSString *)fs_getDocumentsDirectoryForFile:(NSString *)fileName;

+ (NSString *)fs_getLibraryDirectoryForFile:(NSString *)fileName;

+ (NSString *)fs_getCacheDirectoryForFile:(NSString *)fileName;

/**
 *  删除某个文件
 */
+ (BOOL)fs_deleteFile:(NSString *)fileName fromDirectory:(FSDirectoryType)directory;

/**
 *  移动文件
 */
+ (BOOL)fs_moveLocalFile:(NSString *)fileName
           fromDirectory:(FSDirectoryType)origin
             toDirectory:(FSDirectoryType)destination;

/**
 *  移动某个文件去某个文件夹
 *  @param folderName 文件夹名，没有会创建
 */
+ (BOOL)fs_moveLocalFile:(NSString *)fileName
           fromDirectory:(FSDirectoryType)origin
             toDirectory:(FSDirectoryType)destination
          withFolderName:(NSString *)folderName;

/**
 *  复制文件
 */
+ (BOOL)fs_copyFileAtPath:(NSString *)origin
                toNewPath:(NSString *)destination;

/**
 *  重命名
 *
 *  @param origin  原始主目录
 *  @param path    sub路径
 *  @param oldName 旧文件名
 *  @param newName 新文件名
 */
+ (BOOL)fs_renameFileFromDirectory:(FSDirectoryType)origin
                            atPath:(NSString *)path
                       withOldName:(NSString *)oldName
                        andNewName:(NSString *)newName;

/**
 *  通过给定的key，获取App seting
 */
+ (id)fs_getAppSettingsForObjectWithKey:(NSString *)objKey;

/**
 *  通过给定的key，存储App seting
 */
+ (BOOL)fs_setAppSettingsForObject:(id)value
                            forKey:(NSString *)objKey;


@end