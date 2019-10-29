//
//  FSLog.h
//  FSExtensionDemo
//
//  Created by Fussa on 2019/10/29.
//  Copyright © 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

void DefineFSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);

@interface FSLog : NSObject

///log 内容写入本地文件中，使用方式同NSLog
#define FSLog(args ...) DefineFSLog(__FILE__, __LINE__, __PRETTY_FUNCTION__, args);

/// 日志目录路径
+(NSString *)logDirectoryPath;

/// 日志文件路径
+(NSString *)logFilePath;

/// 写日志到文件中
+(void)writeLog:(NSString *)logString;

@end
