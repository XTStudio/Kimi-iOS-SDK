//
//  NSFileManager+Kimi.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/7/10.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSFileManager+Kimi.h"
#import "EDOExporter.h"
#import "NSBundle+Kimi.h"

@implementation NSFileManager (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"FileManager", nil);
    EDO_EXPORT_INITIALIZER({
        return [NSFileManager defaultManager];
    });
    EDO_EXPORT_SCRIPT(@";Initializer.defaultManager = new Initializer;");
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:[NSString stringWithFormat:@"Initializer.documentDirectory = '%@/'",
                                                            NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject]
                                             isInnerScript:YES];
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:[NSString stringWithFormat:@"Initializer.libraryDirectory = '%@/'",
                                                            NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject]
                                             isInnerScript:YES];
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:[NSString stringWithFormat:@"Initializer.cacheDirectory = '%@/'",
                                                            NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject]
                                             isInnerScript:YES];
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:[NSString stringWithFormat:@"Initializer.temporaryDirectory = '%@'", NSTemporaryDirectory()]
                                             isInnerScript:YES];
    [[EDOExporter sharedExporter] exportScriptToJavaScript:[self class]
                                                    script:@"Initializer.jsBundleDirectory = '/com.xt.bundle.js/'"
                                             isInnerScript:YES];
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
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        JSValue *jsBundleRef = [[JSContext currentContext] evaluateScript:@"Bundle.js"];
        KIMIJSBundle *jsBundle = [[EDOExporter sharedExporter] nsValueWithJSValue:jsBundleRef];
        NSString *basePath = [atPath stringByReplacingOccurrencesOfString:@"/com.xt.bundle.js/" withString:@""];
        NSMutableArray *results = [NSMutableArray array];
        for (NSString *aKey in [jsBundle.resources allKeys]) {
            if (basePath.length == 0 || [aKey hasPrefix:basePath]) {
                NSString *trimPath = [aKey substringFromIndex:basePath.length];
                if ([trimPath hasPrefix:@"/"]) {
                    trimPath = [trimPath substringFromIndex:1];
                }
                if ([trimPath containsString:@"/"]) {
                    if (deepSearch) {
                        [results addObject:trimPath];
                    }
                }
                else {
                    [results addObject:trimPath];
                }
            }
        }
        return results.copy;
    }
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
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        return [NSError errorWithDomain:@"FileManager" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"readonly."}];
    }
    NSError *error;
    [self createDirectoryAtPath:atPath withIntermediateDirectories:withIntermediateDirectories attributes:nil error:&error];
    return error;
}

- (NSError *)edo_createFile:(NSString *)atPath data:(NSData *)data {
    if (data == nil) {
        return [NSError errorWithDomain:@"FileManager" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"null data."}];
    }
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        return [NSError errorWithDomain:@"FileManager" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"readonly."}];
    }
    NSError *error;
    [data writeToFile:atPath options:NSDataWritingAtomic error:&error];
    return error;
}

- (NSData *)edo_readFile:(NSString *)atPath {
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        JSValue *jsBundleRef = [[JSContext currentContext] evaluateScript:@"Bundle.js"];
        KIMIJSBundle *jsBundle = [[EDOExporter sharedExporter] nsValueWithJSValue:jsBundleRef];
        if ([jsBundle isKindOfClass:[KIMIJSBundle class]]) {
            NSString *base64String = jsBundle.resources[[atPath stringByReplacingOccurrencesOfString:@"/com.xt.bundle.js/" withString:@""]];
            if (base64String != nil) {
                return [[NSData alloc] initWithBase64EncodedString:base64String options:kNilOptions];
            }
        }
        return nil;
    }
    return [NSData dataWithContentsOfFile:atPath];
}

- (NSError *)edo_removeItem:(NSString *)atPath {
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        return [NSError errorWithDomain:@"FileManager" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"readonly."}];
    }
    NSError *error;
    [self removeItemAtPath:atPath error:&error];
    return error;
}

- (NSError *)edo_copyItem:(NSString *)atPath toPath:(NSString *)toPath {
    NSError *error;
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        NSData *data = [self edo_readFile:atPath];
        if (data == nil) {
            return [NSError errorWithDomain:@"FileManager" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"file not exists."}];
        }
        [data writeToFile:toPath options:NSDataWritingAtomic error:&error];
        return error;
    }
    [self copyItemAtPath:atPath toPath:toPath error:&error];
    return error;
}

- (NSError *)edo_moveItem:(NSString *)atPath toPath:(NSString *)toPath {
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        return [NSError errorWithDomain:@"FileManager" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"readonly."}];
    }
    NSError *error;
    [self moveItemAtPath:atPath toPath:toPath error:&error];
    return error;
}

- (BOOL)edo_fileExists:(NSString *)atPath {
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        JSValue *jsBundleRef = [[JSContext currentContext] evaluateScript:@"Bundle.js"];
        KIMIJSBundle *jsBundle = [[EDOExporter sharedExporter] nsValueWithJSValue:jsBundleRef];
        if ([jsBundle isKindOfClass:[KIMIJSBundle class]]) {
            return jsBundle.resources[[atPath stringByReplacingOccurrencesOfString:@"/com.xt.bundle.js/" withString:@""]] != nil;
        }
        return NO;
    }
    BOOL isDirectory;
    BOOL exists = [self fileExistsAtPath:atPath isDirectory:&isDirectory];
    return exists && !isDirectory;
}

- (BOOL)edo_dirExists:(NSString *)atPath {
    if ([atPath hasPrefix:@"/com.xt.bundle.js/"]) {
        return NO;
    }
    BOOL isDirectory;
    BOOL exists = [self fileExistsAtPath:atPath isDirectory:&isDirectory];
    return exists && isDirectory;
}

@end
