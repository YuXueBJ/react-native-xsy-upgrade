//
//  XSYJSVersion.h
//  XSYUpgrade
//
//  Created by purple on 16/6/12.
//  Copyright © 2016年 purple. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *const currentVersion = @"XSY_JS_VERSION";
@interface XSYJSVersion : NSObject
+(void) setVersion:(NSString *) version;
+(NSString *) getBaseVersion;//打包时候的版本
+(NSString *) getCurrentVersion;//当前升级到的最新版本
+(NSString *) getVersionPath:(NSString *) version;
+(NSString *) getVersionPathOrCreate:(NSString *) version;
+(NSString *) getVersionBundlePath:(NSString *) version;
+(NSURL *) currentVersionBundleURL;
+ (BOOL)versionDesc:(NSString *)source target:(NSString *)target;
@end
