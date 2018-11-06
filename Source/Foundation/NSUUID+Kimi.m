//
//  NSUUID+Kimi.m
//  Kimi-iOS-SDKTests
//
//  Created by PonyCui on 2018/7/9.
//  Copyright © 2018年 XT Studio. All rights reserved.
//

#import "NSUUID+Kimi.h"
#import <xt_engine/EDOExporter.h>

@implementation NSUUID (Kimi)

+ (void)load {
    EDO_EXPORT_CLASS(@"UUID", nil);
    EDO_EXPORT_INITIALIZER({
        if (0 < arguments.count && [arguments[0] isKindOfClass:[NSString class]]) {
            return [[NSUUID alloc] initWithUUIDString:arguments[0]];
        }
        return [NSUUID UUID];
    })
    EDO_EXPORT_READONLY_PROPERTY(@"UUIDString");
}

@end
