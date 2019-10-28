//
//  NSObject+runtime.h
//  SWWH
//
//  Created by Fussa on 16/9/10.
//  Copyright © 2016年 cy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (FS)
@end

@interface NSArray (FSRuntime)
@end

@interface NSMutableArray (FSRuntime)
@end



@interface NSObject (FSUtil)
/**
 * 获取Documents目录
 */
- (NSString *)fs_getDocumentPath;

/**
 * 获取tmp目录
 */
- (NSString *)fs_getTemporaryPath;

/**
 * 获取Library目录
 */
- (NSString *)fs_getLibraryPath;

/**
 * 获取Library/Caches目录
 * 通常情况下，Preferences由系统维护，我们很少去操作TA
 */
- (NSString *)fs_getCachesPath;

/**
 * 获取Library/Preferences目录
 */
- (NSString *)fs_getPreferencesPath;

/**
 * 获取应用程序包的路径
 */
- (NSString *)fs_getResourcePath;

/**
 * 字符串写入沙盒
 */
- (void)fs_writeToFileWithString:(NSString *)string Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 向Document写入字符串
 */
- (void)fs_writeToDocumentFileWithString:(NSString *)string withFileName:(NSString *)fileName;

/**
 * 从沙盒读字符串
 */
- (NSString *)fs_getStringWithContentsOfFile:(NSString *)path;

/**
 * 数组写入文件执行的方法
 */
- (void)fs_writeToFileWithArray:(NSArray *)array Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 向Document写入数据数组
 */
- (void)fs_writeToDocumentFileWithArray:(NSArray *)array Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 从文件中读取数据数组的方法
 */
- (NSArray *)fs_getArrayWithContentsOfFile:(NSString *)path;

/**
 * 字典写入时执行的方法
 */
- (void)fs_writeToFileWithDictionary:(NSDictionary *)dictionary Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 向Document写入数据字典
 */
- (void)fs_writeToDocumentFileWithDictionary:(NSDictionary *)dictionary Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 从文件中读取数据字典的方法
 */
- (NSDictionary *)fs_getDictionaryWithContentsOfFile:(NSString *)path;

/**
 * 向文件中存入NSData
 */
- (void)fs_writeToFileWithData:(NSData *)data Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 向Document写入NSData
 */
- (void)fs_writeToDocumentFileWithData:(NSData *)data Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 从文件中读取NSData
 */
- (NSData *)fs_getDataWithContentsOfFile:(NSString *)path;

/**
 * 向文件中存入图片
 */
- (void)fs_writeToFileWithImage:(UIImage *)image Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 向Document写入图片
 */
- (void)fs_writeToDocumentFileWithImage:(UIImage *)image Path:(NSString *)path withFileName:(NSString *)fileName;

/**
 * 从文件中读取图片
 */
- (UIImage *)fs_getImageWithContentsOfFile:(NSString *)path;

/**
 * 图片转data
 */
- (NSData *)fs_resetSizeOfImageDataWith:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;

/**
 * 重设图片尺寸
 */
- (UIImage *)fs_newSizeImageWith:(UIImage *)sourceImage maxSize:(CGSize)size;

/**
 * 创建二维码
 * @param url 二维码地址
 * @return 二维码图片
 */
- (CIImage *)fs_creatCIQRCodeImageWith:(NSString *)url;

 /**
  * 设置导航栏颜色
  */
- (void)fs_setupStatusBarWithColor:(UIColor *)color;

/**
 * 获取设备名称
 */
- (NSString *)fs_getDeviceName;

@end