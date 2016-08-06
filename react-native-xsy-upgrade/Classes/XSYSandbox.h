//
//  XSYSandbox.h
//  ingageplatform
//
//  Created by purple on 16/6/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSYSandbox : NSObject
+ (NSString *)homePath;
+ (NSString *)docPath;
+ (NSString *)jsPath;
+ (NSString *)jsPathExistsOrCreate;
+ (BOOL)existsOrCreate:(NSString *)path;
@end
