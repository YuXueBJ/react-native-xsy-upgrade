//
//  XSYJSVersion.m
//  XSYUpgrade
//
//  Created by purple on 16/6/12.
//  Copyright © 2016年 purple. All rights reserved.
//

#import "XSYJSVersion.h"
#import "XSYSandbox.h"


static NSString *const bundleName = @"index.ios.jsbundle";
@implementation XSYJSVersion

+(void) setVersion:(NSString *) version{
    [[NSUserDefaults standardUserDefaults] setValue:version forKey:currentVersion];
}

+ (BOOL)versionDesc:(NSString *)source target:(NSString *)target
{
    return [source compare:target options:NSNumericSearch] == NSOrderedDescending;
}

+(NSString *) getCurrentVersion{
    NSString * version = [[NSUserDefaults standardUserDefaults] objectForKey:currentVersion];
    //保证当前版本和基线版本中的最新版本返回
    if(!version){
        version =  @"0";
    }
    NSString * baseVersion = [self getBaseVersion];
    if([self versionDesc:baseVersion target:version]){
        version = baseVersion;
    }

    return version;
}

+(NSString *) getBaseVersion{
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString * baseVersion = info[@"jsVersion"];
    if(!baseVersion){
        return @"0";
    }
    return baseVersion;
}


+(NSString *) getVersionPath:(NSString *) version{
    NSString * jspatch = [XSYSandbox jsPath];
    if (!jspatch) {
        return nil;
    }
    NSString * versionPath = [NSString stringWithFormat:@"%@/%@",jspatch,version];
    if (![[NSFileManager defaultManager] fileExistsAtPath:versionPath]){
        return nil;
    }
    return versionPath;
}

+(NSString *) getVersionPathOrCreate:(NSString *) version{
    NSString * jspatch = [XSYSandbox jsPathExistsOrCreate];
    NSString * versionPath = [NSString stringWithFormat:@"%@/%@",jspatch,version];
    if (![XSYSandbox existsOrCreate:versionPath]){
        return nil;
    }
    return versionPath;
}

+(NSString *) getVersionBundlePath:(NSString *) version{
    NSString * jspatch = [self getVersionPath:version];
    if (!jspatch) {
        return nil;
    }
    NSString * versionPath = [NSString stringWithFormat:@"%@/%@",jspatch,bundleName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:versionPath]){
        return nil;
    }
    return versionPath;
}

+(NSURL *) currentVersionBundleURL
{
    NSString * currentVersion = [self getCurrentVersion];
    NSString * jspath = [XSYSandbox jsPath];
    NSURL * defaultURL = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
    if (!jspath) {
        return defaultURL;
    }
    
    NSString * currentVersionPath = [self getVersionBundlePath:currentVersion];
    if (!currentVersionPath) {
        return defaultURL;
    }
    NSURL * bundleUrl = [NSURL fileURLWithPath:currentVersionPath];
    return bundleUrl;
}
@end
