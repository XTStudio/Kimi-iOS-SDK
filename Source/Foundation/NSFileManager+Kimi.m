//
//  NSFileManager+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSFileManager+Kimi.h"
#import <Endo/EDOExporter.h>

@implementation NSFileManager (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"FileManager", nil);
    EDO_EXPORT_INITIALIZER({
        return [NSFileManager defaultManager];
    });
    EDO_EXPORT_SCRIPT(@";Initializer.defaultManager = new Initializer;");
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:[NSString stringWithFormat:@";Initializer.documentDirectory = '%@/';",
                                                            NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject]];
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:[NSString stringWithFormat:@";Initializer.libraryDirectory = '%@/';",
                                                            NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject]];
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:[NSString stringWithFormat:@";Initializer.cacheDirectory = '%@/';",
                                                            NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject]];
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:[NSString stringWithFormat:@";Initializer.temporaryDirectory = '%@';", NSTemporaryDirectory()]];
    EDO_EXPORT_METHOD_ALIAS(edo_subpathsAtPath:deepSearch:, @"subpaths");
    EDO_EXPORT_METHOD_ALIAS(edo_createDirectory:withIntermediateDirectories:, @"createDirectory");
    EDO_EXPORT_METHOD_ALIAS(edo_createFile:data:, @"createFile");
    EDO_EXPORT_METHOD_ALIAS(edo_readFile:, @"readFile");
    EDO_EXPORT_METHOD_ALIAS(edo_removeItem:, @"removeItem");
    EDO_EXPORT_METHOD_ALIAS(edo_copyItem:toPath:, @"copyItem");
    EDO_EXPORT_METHOD_ALIAS(edo_moveItem:toPath:, @"moveItem");
    EDO_EXPORT_METHOD_ALIAS(edo_fileExists:, @"fileExists");
    EDO_EXPORT_METHOD_ALIAS(edo_dirExists:, @"dirExists");
}

- (NSArray<NSString *> *)edo_subpathsAtPath:(NSString *)atPath deepSearch:(BOOL)deepSearch {
    NSMutableArray *result = [NSMutableArray array];
    for (NSString *subPath in [self enumeratorAtPath:atPath]) {
        if (!deepSearch && [subPath containsString:@"/"]) {
            continue;
        }
        [result addObject:subPath];
    }
    return [result copy];
}

- (NSError *)edo_createDirectory:(NSString *)atPath withIntermediateDirectories:(BOOL)withIntermediateDirectories {
    NSError *error;
    [self createDirectoryAtPath:atPath withIntermediateDirectories:withIntermediateDirectories attributes:nil error:&error];
    return error;
}

- (NSError *)edo_createFile:(NSString *)atPath data:(NSData *)data {
    if (data == nil) {
        return [NSError errorWithDomain:@"FileManager" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"null data."}];
    }
    NSError *error;
    [data writeToFile:atPath options:NSDataWritingAtomic error:&error];
    return error;
}

- (NSData *)edo_readFile:(NSString *)atPath {
    return [NSData dataWithContentsOfFile:atPath];
}

- (NSError *)edo_removeItem:(NSString *)atPath {
    NSError *error;
    [self removeItemAtPath:atPath error:&error];
    return error;
}

- (NSError *)edo_copyItem:(NSString *)atPath toPath:(NSString *)toPath {
    NSError *error;
    [self copyItemAtPath:atPath toPath:toPath error:&error];
    return error;
}

- (NSError *)edo_moveItem:(NSString *)atPath toPath:(NSString *)toPath {
    NSError *error;
    [self moveItemAtPath:atPath toPath:toPath error:&error];
    return error;
}

- (BOOL)edo_fileExists:(NSString *)atPath {
    BOOL isDirectory;
    BOOL exists = [self fileExistsAtPath:atPath isDirectory:&isDirectory];
    return exists && !isDirectory;
}

- (BOOL)edo_dirExists:(NSString *)atPath {
    BOOL isDirectory;
    BOOL exists = [self fileExistsAtPath:atPath isDirectory:&isDirectory];
    return exists && isDirectory;
}

@end
