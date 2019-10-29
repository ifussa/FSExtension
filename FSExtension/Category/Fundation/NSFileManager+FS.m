//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "NSFileManager+FS.h"
#import "FSGlobal.h"

@implementation NSFileManager (FS)

+ (NSString *)fs_readTextFile:(NSString *)file ofType:(NSString *)type
{
    NSString *temp = [[NSBundle mainBundle] pathForResource:file ofType:type];
    file = [NSString stringWithContentsOfFile:temp encoding:NSStringEncodingConversionAllowLossy error:nil];
    return file;
}

+ (BOOL)saveArrayToPath:(FSDirectoryType)path withFilename:(NSString *)fileName array:(NSArray *)array
{
    NSString *_path;

    switch(path)
    {
        case FSDirectoryTypeMainBundle:
            _path = [self fs_getBundlePathForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case FSDirectoryTypeLibrary:
            _path = [self fs_getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case FSDirectoryTypeDocuments:
            _path = [self fs_getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case FSDirectoryTypeCache:
            _path = [self fs_getCacheDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        default:
            break;
    }

    //BFLog(@"savedArrayToFile : %@",path);
    return [NSKeyedArchiver archiveRootObject:array toFile:_path];
}

+ (NSArray *)loadArrayFromPath:(FSDirectoryType)path withFilename:(NSString *)fileName
{
    NSString *_path;

    switch(path)
    {
        case FSDirectoryTypeMainBundle:
            _path = [self fs_getBundlePathForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case FSDirectoryTypeLibrary:
            _path = [self fs_getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case FSDirectoryTypeDocuments:
            _path = [self fs_getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case FSDirectoryTypeCache:
            _path = [self fs_getCacheDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        default:
            break;
    }

    //BFLog(@"loadedArrayFromFile : %@",_path);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
}

+ (NSString *)fs_getBundlePathForFile:(NSString *)fileName
{
    NSString *fileExtension = [fileName pathExtension];
    return [[NSBundle mainBundle] pathForResource:[fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", fileExtension] withString:@""] ofType:fileExtension];
}

+ (NSString *)fs_getDocumentsDirectoryForFile:(NSString *)fileName
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)fs_getLibraryDirectoryForFile:(NSString *)fileName
{
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)fs_getCacheDirectoryForFile:(NSString *)fileName
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [cacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (BOOL)fs_deleteFile:(NSString *)fileName fromDirectory:(FSDirectoryType)directory
{
    if(fileName.length > 0)
    {
        NSString *path;

        switch(directory)
        {
            case FSDirectoryTypeMainBundle:
                path = [self fs_getBundlePathForFile:fileName];
                break;
            case FSDirectoryTypeLibrary:
                path = [self fs_getLibraryDirectoryForFile:fileName];
                break;
            case FSDirectoryTypeDocuments:
                path = [self fs_getDocumentsDirectoryForFile:fileName];
                break;
            case FSDirectoryTypeCache:
                path = [self fs_getCacheDirectoryForFile:fileName];
                break;
            default:
                break;
        }

        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        else
        {
            return NO;
        }
    }

    return NO;
}

+ (BOOL)fs_moveLocalFile:(NSString *)fileName fromDirectory:(FSDirectoryType)origin toDirectory:(FSDirectoryType)destination
{
    return [self fs_moveLocalFile:fileName fromDirectory:origin toDirectory:destination withFolderName:nil];
}

+ (BOOL)fs_moveLocalFile:(NSString *)fileName fromDirectory:(FSDirectoryType)origin toDirectory:(FSDirectoryType)destination withFolderName:(NSString *)folderName
{
    NSString *originPath;

    switch(origin)
    {
        case FSDirectoryTypeMainBundle:
            originPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
            break;
        case FSDirectoryTypeLibrary:
            originPath = [self fs_getDocumentsDirectoryForFile:fileName];
            break;
        case FSDirectoryTypeDocuments:
            originPath = [self fs_getLibraryDirectoryForFile:fileName];
            break;
        case FSDirectoryTypeCache:
            originPath = [self fs_getCacheDirectoryForFile:fileName];
            break;
        default:
            break;
    }

    NSString *destinationPath;

    switch(destination)
    {
        case FSDirectoryTypeMainBundle:
            if(folderName)
                destinationPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/%@", folderName, fileName] ofType:nil];
            else
                destinationPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
            break;
        case FSDirectoryTypeLibrary:
            if(folderName)
                destinationPath = [self fs_getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@/%@", folderName, fileName]];
            else
                destinationPath = [self fs_getLibraryDirectoryForFile:fileName];
            break;
        case FSDirectoryTypeDocuments:
            if(folderName)
                destinationPath = [self fs_getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@/%@", folderName, fileName]];
            else
                destinationPath = [self fs_getDocumentsDirectoryForFile:fileName];
            break;
        case FSDirectoryTypeCache:
            if(folderName)
                destinationPath = [self fs_getCacheDirectoryForFile:[NSString stringWithFormat:@"%@/%@", folderName, fileName]];
            else
                destinationPath = [self fs_getCacheDirectoryForFile:fileName];
            break;
        default:
            break;
    }

    // Check if folder exist, if not, create automatically
    if(folderName)
    {
        NSString *folderPath = [NSString stringWithFormat:@"%@/%@", destinationPath, folderName];
        if(![[NSFileManager defaultManager] fileExistsAtPath:folderPath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }

    BOOL copied = NO, deleted = NO;

    if([[NSFileManager defaultManager] fileExistsAtPath:originPath])
    {
        if([[NSFileManager defaultManager] copyItemAtPath:originPath toPath:destinationPath error:nil])
            copied = YES;
    }

    if(destination != FSDirectoryTypeMainBundle)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:originPath])
            if([[NSFileManager defaultManager] removeItemAtPath:originPath error:nil])
                deleted = YES;
    }

    if(copied && deleted)
        return YES;
    else
        return NO;
}

+ (BOOL)fs_copyFileAtPath:(NSString *)origin toNewPath:(NSString *)destination
{
    if([[NSFileManager defaultManager] fileExistsAtPath:origin])
        return [[NSFileManager defaultManager] copyItemAtPath:origin toPath:destination error:nil];
    else
        return NO;
}

+ (BOOL)fs_renameFileFromDirectory:(FSDirectoryType)origin atPath:(NSString *)path withOldName:(NSString *)oldName andNewName:(NSString *)newName
{
    NSString *originPath;

    switch(origin)
    {
        case FSDirectoryTypeMainBundle:
            originPath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
            break;
        case FSDirectoryTypeLibrary:
            originPath = [self fs_getDocumentsDirectoryForFile:path];
            break;
        case FSDirectoryTypeDocuments:
            originPath = [self fs_getLibraryDirectoryForFile:path];
            break;
        case FSDirectoryTypeCache:
            originPath = [self fs_getCacheDirectoryForFile:path];
            break;
        default:
            break;
    }

    if([[NSFileManager defaultManager] fileExistsAtPath:originPath])
    {
        NSString *newNamePath = [originPath stringByReplacingOccurrencesOfString:oldName withString:newName];
        if([[NSFileManager defaultManager] copyItemAtPath:originPath toPath:newNamePath error:nil])
        {
            if([[NSFileManager defaultManager] removeItemAtPath:originPath error:nil])
                return YES;
            else
                return NO;
        }
        else
            return NO;
    }
    else
        return NO;
}

+ (id)fs_getAppSettingsForObjectWithKey:(NSString *)objKey
{
    return [self getSettings:FS_APP_NAME objectForKey:objKey];
}

+ (BOOL)fs_setAppSettingsForObject:(id)value forKey:(NSString *)objKey
{
    return [self setSettings:FS_APP_NAME object:value forKey:objKey];
}

+ (id)getSettings:(NSString *)settings objectForKey:(NSString *)objKey
{
    NSString *path = [self fs_getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@-Settings.plist", settings]];
    NSDictionary *loadedPlist = [NSDictionary dictionaryWithContentsOfFile:path];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@-Settings", settings] ofType:@"plist"];
        [self fs_moveLocalFile:[NSString stringWithFormat:@"%@-Settings.plist", settings] fromDirectory:FSDirectoryTypeMainBundle toDirectory:FSDirectoryTypeLibrary withFolderName:@""];
        loadedPlist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    }

    return [loadedPlist objectForKey:objKey];
}

+ (BOOL)setSettings:(NSString *)settings object:(id)value forKey:(NSString *)objKey
{
    NSString *path = [self fs_getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@-Settings.plist", settings]];
    NSMutableDictionary *loadedPlist = [NSMutableDictionary dictionaryWithContentsOfFile:path];

    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@-Settings", settings] ofType:@"plist"];
        [self fs_moveLocalFile:[NSString stringWithFormat:@"%@-Settings.plist", settings] fromDirectory:FSDirectoryTypeMainBundle toDirectory:FSDirectoryTypeLibrary withFolderName:@""];
        loadedPlist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    }

    [loadedPlist setObject:value forKey:objKey];
    return [loadedPlist writeToFile:path atomically:YES];
}


@end