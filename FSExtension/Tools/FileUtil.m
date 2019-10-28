//
// Created by Yimi on 2018/6/1.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "FileUtil.h"


@implementation FileUtil
- (NSString *)getDocumentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)getTemporaryPath {
    return NSTemporaryDirectory();
}

- (NSString *)getLibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)getCachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)getPreferencesPath {
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *)getResourcePath {
    return [[NSBundle mainBundle] resourcePath];
}

- (void)writeToFileWithstring:(NSString *)string Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)writeToDocumentFileWithstring:(NSString *)string withFileName:(NSString *)fileName {
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:fileName];
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)getStringWithContentsOfFile:(NSString *)path {
    return [NSString stringWithContentsOfFile:path usedEncoding:NSUTF8StringEncoding error:nil];
}

- (void)writeToFileWithArray:(NSArray *)array Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [array writeToFile:filePath atomically:YES];
}

- (void)writeToDocumentFileWithArray:(NSArray *)array Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:fileName];
    [array writeToFile:filePath atomically:YES];
}

- (NSArray *)getArrayWithContentsOfFile:(NSString *)path {
    return [NSArray arrayWithContentsOfFile:path];
}

- (void)writeToFileWithDictionary:(NSDictionary *)dictionary Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [dictionary writeToFile:filePath atomically:YES];
}

- (void)writeToDocumentFileWithDictionary:(NSDictionary *)dictionary Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:fileName];
    [dictionary writeToFile:filePath atomically:YES];
}

- (NSDictionary *)getDictionaryWithContentsOfFile:(NSString *)path {
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

- (void)writeToFileWithData:(NSData *)data Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [data writeToFile:filePath atomically:YES];
}

- (void)writeToDocumentFileWithData:(NSData *)data Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:fileName];
    [data writeToFile:filePath atomically:YES];
}

- (NSData *)getDataWithContentsOfFile:(NSString *)path {
    return [NSData dataWithContentsOfFile:path];
}

- (void)writeToFileWithImage:(UIImage *)image Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSData *data = UIImageJPEGRepresentation(image, 0);
    [data writeToFile:filePath atomically:YES];
}

- (void)writeToDocumentFileWithImage:(UIImage *)image Path:(NSString *)path withFileName:(NSString *)fileName {
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:fileName];
    NSData *data = UIImageJPEGRepresentation(image, 0);
    [data writeToFile:filePath atomically:YES];
}

- (UIImage *)getImageWithContentsOfFile:(NSString *)path {
    NSData *resultData = [NSData dataWithContentsOfFile:path];
    return [UIImage imageWithData:resultData];
}
//
//+ (NSDictionary *)readLocalJsonFileWithName:(NSString *)name  {
//    // 获取文件路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
//    // 将文件数据化
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//    // 对数据进行JSON格式化并返回字典形式
//
//    // NSJSONReadingOptions 说明：
//    // 1、直接填0                          返回的对象是不可变的，NSDictionary或NSArray
//    // 2、NSJSONReadingMutableLeaves      返回的JSON对象中字符串的值类型为NSMutableString
//    // 3、NSJSONReadingMutableContainers  返回可变容器，NSMutableDictionary或NSMutableArray，返回的是数组字典嵌套的情况，每一层都是可变的
//    // 4、NSJSONReadingAllowFragments     允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment
//    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//}

@end