//
//  FileManagerTests.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/11.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"

@interface FileManagerTests : XCTestCase

@end

@implementation FileManagerTests

- (void)tearDown {
    [super tearDown];
    for (NSString *item in [[NSFileManager defaultManager] enumeratorAtPath:NSTemporaryDirectory()]) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), item] error:NULL];
    }
}

- (void)testSubpaths {
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/fooDir", NSTemporaryDirectory()]
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:NULL];
    [[@"string value" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/fooDir/bar.txt", NSTemporaryDirectory()]
                                                                  options:NSDataWritingAtomic
                                                                    error:NULL];
    [[@"foo value" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/xxx.txt", NSTemporaryDirectory()]
                                                                  options:NSDataWritingAtomic
                                                                    error:NULL];
    [[AppDelegate unitTestContext] evaluateScript:@"var subpaths = FileManager.defaultManager.subpaths(FileManager.temporaryDirectory, true)"];
    XCTAssertTrue([[AppDelegate unitTestContext] evaluateScript:@"subpaths.indexOf('fooDir/bar.txt') >= 0"].toBool);
    XCTAssertTrue([[AppDelegate unitTestContext] evaluateScript:@"subpaths.indexOf('fooDir') >= 0"].toBool);
    XCTAssertTrue([[AppDelegate unitTestContext] evaluateScript:@"subpaths.indexOf('xxx.txt') >= 0"].toBool);
    [[AppDelegate unitTestContext] evaluateScript:@"var subpaths = FileManager.defaultManager.subpaths(FileManager.temporaryDirectory, false)"];
    XCTAssertFalse([[AppDelegate unitTestContext] evaluateScript:@"subpaths.indexOf('fooDir/bar.txt') >= 0"].toBool);
    XCTAssertTrue([[AppDelegate unitTestContext] evaluateScript:@"subpaths.indexOf('fooDir') >= 0"].toBool);
    XCTAssertTrue([[AppDelegate unitTestContext] evaluateScript:@"subpaths.indexOf('xxx.txt') >= 0"].toBool);
}

- (void)testCreateDirectory {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"FileManager.defaultManager.createDirectory(FileManager.temporaryDirectory + '/tttDir', true)"];
    BOOL isDir;
    [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/tttDir", NSTemporaryDirectory()] isDirectory:&isDir];
    XCTAssertTrue(isDir);
    [context evaluateScript:@"FileManager.defaultManager.createDirectory(FileManager.temporaryDirectory + '/tttDir/eeeDir', true)"];
    BOOL isDir2;
    [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/tttDir/eeeDir", NSTemporaryDirectory()] isDirectory:&isDir2];
    XCTAssertTrue(isDir2);
}

- (void)testCreateFile {
    JSContext *context = [AppDelegate unitTestContext];
    [context evaluateScript:@"FileManager.defaultManager.createFile(FileManager.temporaryDirectory + '/ttt.txt', new Data({utf8String: 'Hello, World!'}))"];
    NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/ttt.txt", NSTemporaryDirectory()]];
    XCTAssertTrue([[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] isEqualToString:@"Hello, World!"]);
}

- (void)testReadFile {
    [[@"String Value" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/ttt.txt", NSTemporaryDirectory()] atomically:YES];
    NSString *readString = [[AppDelegate unitTestContext] evaluateScript:@"FileManager.defaultManager.readFile(FileManager.temporaryDirectory + '/ttt.txt').utf8String()"].toString;
    XCTAssertTrue([readString isEqualToString:@"String Value"]);
}

- (void)testRemoveItem {
    [[@"" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/ttt.txt", NSTemporaryDirectory()] atomically:YES];
    [[AppDelegate unitTestContext] evaluateScript:@"FileManager.defaultManager.removeItem(FileManager.temporaryDirectory + '/ttt.txt')"];
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/ttt.txt", NSTemporaryDirectory()]];
    XCTAssertFalse(result);
}

- (void)testCopyItem {
    [[@"String Value" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/ttt.txt", NSTemporaryDirectory()] atomically:YES];
    [[AppDelegate unitTestContext] evaluateScript:@"FileManager.defaultManager.copyItem(FileManager.temporaryDirectory + '/ttt.txt', FileManager.temporaryDirectory + '/eee.txt')"];
    NSString *readString = [[AppDelegate unitTestContext] evaluateScript:@"FileManager.defaultManager.readFile(FileManager.temporaryDirectory + '/eee.txt').utf8String()"].toString;
    XCTAssertTrue([readString isEqualToString:@"String Value"]);
}

- (void)testMoveItem {
    [[@"String Value" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/ttt.txt", NSTemporaryDirectory()] atomically:YES];
    [[AppDelegate unitTestContext] evaluateScript:@"FileManager.defaultManager.moveItem(FileManager.temporaryDirectory + '/ttt.txt', FileManager.temporaryDirectory + '/eee.txt')"];
    NSString *readString = [[AppDelegate unitTestContext] evaluateScript:@"FileManager.defaultManager.readFile(FileManager.temporaryDirectory + '/eee.txt').utf8String()"].toString;
    XCTAssertTrue([readString isEqualToString:@"String Value"]);
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/ttt.txt", NSTemporaryDirectory()]];
    XCTAssertFalse(result);
}

- (void)testFileExists {
    [[@"String Value" dataUsingEncoding:NSUTF8StringEncoding] writeToFile:[NSString stringWithFormat:@"%@/ttt.txt", NSTemporaryDirectory()] atomically:YES];
    XCTAssertTrue([[AppDelegate unitTestContext] evaluateScript:@"FileManager.defaultManager.fileExists(FileManager.temporaryDirectory + '/ttt.txt')"].toBool);
}

- (void)testDirExists {
    [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/fooDir", NSTemporaryDirectory()]
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:NULL];
    XCTAssertTrue([[AppDelegate unitTestContext] evaluateScript:@"FileManager.defaultManager.dirExists(FileManager.temporaryDirectory + '/fooDir')"].toBool);
}

@end
