//
//  FSLog.m
//  FSExtensionDemo
//
//  Created by Fussa on 2019/10/29.
//  Copyright © 2019 Fussa. All rights reserved.
//

#import "FSLog.h"


#define CurrentFilePath @"SmartCall_t.txt"   ///< 储存当前log文件
#define BackupFilePath @"SmartCall_t_1.txt"  ///< 存储备份log文件
#define LogFileMaxSize 5*1024*1024           ///< log文件最大容量(M)

static dispatch_queue_t writeLogQueue;

@implementation FSLog

+(void)load {
    writeLogQueue = dispatch_queue_create("writeLogQueue", DISPATCH_QUEUE_CONCURRENT); // 创建异步队列，用于写入日志
}

void DefineFSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...) {
    va_list ap;
    va_start (ap, format);
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    NSString *content = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);

    NSString *mode = @"";

#ifdef DEBUG
    NSLog(@"%@",content);
    mode = @"Debug";
#else
    mode = @"Release";
#endif

    //dispatch_barrier_async 保证任务按顺序执行
    dispatch_barrier_async(writeLogQueue, ^{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSSS"];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSString *timeString = [formatter stringFromDate:[NSDate date]];
        NSString *_content = [NSString stringWithFormat:@"%@|%@|%s:%@",timeString,mode,functionName,content];
        [FSLog writeLog:_content];
    });

}

+(NSString *)logDirectoryPath {
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *directoryPath = [documentsPath stringByAppendingPathComponent:@"cylanLog"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:directoryPath]) {
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return directoryPath;
}

+(NSString *)logFilePath {
    return [self filePathForLastPath:CurrentFilePath];
}

+(NSString *)filePathForLastPath:(NSString *)lastPath {
    NSString *logFilePath = [self logDirectoryPath];
    logFilePath = [logFilePath stringByAppendingPathComponent:lastPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [fileManager createFileAtPath:logFilePath contents:nil attributes:nil];
    }
    return logFilePath;
}

///文件大小
+ (float)fileSizeForPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    return  [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
}

+(void)writeLog:(NSString *)logString {
    NSString *filePath = [self filePathForLastPath:CurrentFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([self fileSizeForPath:filePath] > LogFileMaxSize) {

        ///如果当前日志文件容量大于最大容量，拷贝当前日志文件内容到备份文件中，清空当前日志文件
        NSString *backupFilePath = [[self logDirectoryPath] stringByAppendingPathComponent:BackupFilePath];
        if ([fileManager fileExistsAtPath:backupFilePath]) {
            [fileManager removeItemAtPath:backupFilePath error:nil];
        }

        if ([fileManager copyItemAtPath:filePath toPath:backupFilePath error:nil]) {
            [fileManager removeItemAtPath:filePath error:nil];
            filePath = [self filePathForLastPath:CurrentFilePath];
        }

    }
    NSString *jsonStr = logString;
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    // 在文件的末尾添加内容。如果想在开始写 [file seekToFileOffset:0];
    [file seekToEndOfFile];
    NSData *strData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [file writeData:strData];
}

@end
