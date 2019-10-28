//
// Created by Yimi on 2018/6/1.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileUtil : NSObject
/**
 * 获取Documents目录
 */
- (NSString *)getDocumentPath;

/**
 * 获取tmp目录
 * @return
 */
- (NSString *)getTemporaryPath;

/**
 * 获取Library目录
 * @return
 */
- (NSString *)getLibraryPath;

/**
 * 获取Library/Caches目录
 * 通常情况下，Preferences由系统维护，我们很少去操作TA
 * @return
 */
- (NSString *)getCachesPath;

/**
 * 获取Library/Preferences目录
 * @return
 */
- (NSString *)getPreferencesPath;

/**
 * 获取应用程序包的路径
 * @return
 */
- (NSString *)getResourcePath;


/**
 * 字符串写入沙盒
 * @param string
 * @param path
 * @param fileName
 */
- (void)writeToFileWithstring:(NSString *)string Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 向Document写入字符串
 * @param string
 * @param fileName
 */
- (void)writeToDocumentFileWithstring:(NSString *)string withFileName:(NSString *)fileName;

/**
 * 从沙盒读字符串
 * @param path
 * @return
 */
- (NSString *)getStringWithContentsOfFile:(NSString *)path;


/**
 * 数组写入文件执行的方法
 * @param array
 * @param path
 * @param fileName
 */
- (void)writeToFileWithArray:(NSArray *)array Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 向Document写入数据数组
 * @param string
 * @param fileName
 */
- (void)writeToDocumentFileWithArray:(NSArray *)array Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 从文件中读取数据数组的方法
 * @param path
 * @return
 */
- (NSArray *)getArrayWithContentsOfFile:(NSString *)path;


/**
 * 字典写入时执行的方法
 * @param dictionary
 * @param path
 * @param fileName
 */
- (void)writeToFileWithDictionary:(NSDictionary *)dictionary Path:(NSString *)path withFileName:(NSString *)fileName;


/**
 * 向Document写入数据字典
 * @param string
 * @param fileName
 */
- (void)writeToDocumentFileWithDictionary:(NSDictionary *)dictionary Path:(NSString *)path withFileName:(NSString *)fileName;


/**
 * 从文件中读取数据字典的方法
 * @param path
 * @return
 */
- (NSDictionary *)getDictionaryWithContentsOfFile:(NSString *)path;


/**
 * 向文件中存入NSData
 * @param data
 * @param path
 * @param fileName
 */
- (void)writeToFileWithData:(NSData *)data Path:(NSString *)path withFileName:(NSString *)fileName;


/**
 * 向Document写入NSData
 * @param string
 * @param fileName
 */
- (void)writeToDocumentFileWithData:(NSData *)data Path:(NSString *)path withFileName:(NSString *)fileName;


/**
 * 从文件中读取NSData
 * @param path
 * @return
 */
- (NSData *)getDataWithContentsOfFile:(NSString *)path;


/**
 * 向文件中存入图片
 * @param data
 * @param path
 * @param fileName
 */
- (void)writeToFileWithImage:(UIImage *)image Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 向Document写入图片
 * @param string
 * @param fileName
 */
- (void)writeToDocumentFileWithImage:(UIImage *)image Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 从文件中读取图片
 * @param path
 * @return
 */
- (UIImage *)getImageWithContentsOfFile:(NSString *)path;

@end