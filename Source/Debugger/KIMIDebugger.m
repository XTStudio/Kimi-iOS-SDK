//
//  KIMIDebugger.m
//  Kimi-iOS-SDK
//
//  Created by PonyCui on 2018/8/31.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "KIMIDebugger.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <Endo/Endo.h>

@interface KIMIDebuggerLogger: NSObject<DDLogger>

@property (nonatomic, strong) id <DDLogFormatter> logFormatter;
@property (nonatomic, strong) NSString *remoteAddress;

@end

@implementation KIMIDebuggerLogger

- (void)logMessage:(DDLogMessage *)logMessage {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/console", self.remoteAddress]]];
    request.HTTPMethod = @"POST";
    NSString *type = @"log";
    switch (logMessage.flag) {
        case DDLogFlagVerbose:
            type = @"log";
            break;
        case DDLogFlagInfo:
            type = @"info";
            break;
        case DDLogFlagDebug:
            type = @"debug";
            break;
        case DDLogFlagError:
            type = @"error";
            break;
        case DDLogFlagWarning:
            type = @"warn";
            break;
        default:
            break;
    }
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:@{
                                                                 @"type": type,
                                                                 @"values": @[logMessage.message ?: @""],
                                                                 }
                                                       options:kNilOptions
                                                         error:nil];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) { }] resume];
}

@end

@interface KIMIDebugger()

@property (nonatomic, strong) NSString *remoteAddress;
@property (nonatomic, strong) KIMIDebuggerLogger *logger;
@property (nonatomic, strong) UIAlertController *activeAlertController;
@property (nonatomic, assign) BOOL closed;
@property (nonatomic, strong) NSString *lastTag;

@end

@implementation KIMIDebugger

- (instancetype)initWithRemoteAddress:(NSString *)remoteAddress
{
    self = [super init];
    if (self) {
        _remoteAddress = remoteAddress ?:
        [[NSUserDefaults standardUserDefaults] valueForKey:@"com.xt.kimi.debugger.address"] ?:
        @"127.0.0.1:8090";
        _logger = [[KIMIDebuggerLogger alloc] init];
        _logger.remoteAddress = _remoteAddress;
        [self addConsoleHandler];
    }
    return self;
}

- (void)addConsoleHandler {
#ifndef DEBUG
#else
    [DDLog addLogger:self.logger withLevel:DDLogLevelAll];
#endif
}

- (void)connect:(void (^)(JSContext *))callback fallback:(void (^)(void))fallback {
#ifndef DEBUG
    if (fallback) {
        fallback();
    }
#else
    [self displayConnectingDialog:callback fallback:fallback];
    NSString *fetchURLString = [NSString stringWithFormat:@"http://%@/source", self.remoteAddress];
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:fetchURLString]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         if (error == nil && data != nil) {
                                             NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                             JSContext *context = [[JSContext alloc] init];
                                             [[EDOExporter sharedExporter] exportWithContext:context];
                                             [context evaluateScript:script];
                                             [self.activeAlertController dismissViewControllerAnimated:NO completion:nil];
                                             self.activeAlertController = nil;
                                             if (callback) {
                                                 callback(context);
                                             }
                                             [self fetchUpdate:callback fallback:fallback];
                                         }
                                         else {
                                             if (!self.closed) {
                                                 return ;
                                             }
                                             [self.activeAlertController dismissViewControllerAnimated:NO completion:nil];
                                             self.activeAlertController = nil;
                                             if (fallback) {
                                                 fallback();
                                             }
                                         }
                                     });
                                 }] resume];
#endif
}

- (void)fetchUpdate:(void (^)(JSContext *))callback fallback:(void (^)(void))fallback {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *fetchURLString = [NSString stringWithFormat:@"http://%@/version", self.remoteAddress];
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:fetchURLString]
                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             if (error == nil && data != nil) {
                                                 NSString *tag = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                 if (self.lastTag == nil) {
                                                     self.lastTag = tag;
                                                     [self fetchUpdate:callback fallback:fallback];
                                                 }
                                                 else if (![self.lastTag isEqualToString:tag]) {
                                                     self.lastTag = tag;
                                                     [self connect:callback fallback:^{
                                                         
                                                     }];
                                                 }
                                                 else {
                                                     [self fetchUpdate:callback fallback:fallback];
                                                 }
                                             }
                                             else {
                                                 [self fetchUpdate:callback fallback:fallback];
                                             }
                                         });
                                     }] resume];
    });
}

- (void)displayConnectingDialog:(void (^)(JSContext *))callback fallback:(void (^)(void))fallback {
    [self.activeAlertController dismissViewControllerAnimated:NO completion:nil];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController setTitle:@"KIMI Debugger"];
    [alertController setMessage:[NSString stringWithFormat:@"connecting to %@", self.remoteAddress]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Force Close"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          self.closed = YES;
                                                          if (fallback) {
                                                              fallback();
                                                          }
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Modify Address"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [self displayModifyDialog:callback
                                                                           fallback:fallback];
                                                      }]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.activeAlertController) {
            [[self visibleViewController] presentViewController:self.activeAlertController
                                                       animated:NO
                                                     completion:nil];
        }
    });
    self.activeAlertController = alertController;
}

- (void)displayModifyDialog:(void (^)(JSContext *))callback fallback:(void (^)(void))fallback {
    [self.activeAlertController dismissViewControllerAnimated:NO completion:nil];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController setTitle:@"Enter KIMI Debugger Address"];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Input IP:Port Here";
        textField.text = self.remoteAddress;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          self.closed = YES;
                                                          if (fallback) {
                                                              fallback();
                                                          }
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          self.remoteAddress = alertController.textFields[0].text;
                                                          [[NSUserDefaults standardUserDefaults] setObject:self.remoteAddress
                                                                                                    forKey:@"com.xt.kimi.debugger.address"];
                                                          [self connect:callback fallback:fallback];
                                                      }]];
    [[self visibleViewController] presentViewController:alertController animated:NO completion:nil];
    self.activeAlertController = alertController;
}

- (UIViewController *)visibleViewController {
    UIViewController *current = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    while (current.presentedViewController != nil) {
        current = current.presentedViewController;
    }
    return current;
}

- (void)setRemoteAddress:(NSString *)remoteAddress {
    _remoteAddress = remoteAddress;
    self.logger.remoteAddress = remoteAddress;
}

@end
