//
//  XSYSandbox.m
//  ingageplatform
//
//  Created by purple on 16/6/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//
/**
 + (NSString *)homePath;     // 程序主目录，可见子目录(3个):Documents、Library、tmp
 + (NSString *)appPath;        // 程序目录，不能存任何东西
 + (NSString *)docPath;        // 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
 + (NSString *)libPrefPath;    // 配置目录，配置文件存这里
 + (NSString *)libCachePath;    // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
 + (NSString *)tmpPath;        // 临时缓存目录，APP退出后，系统可能会删除这里的内容
 + (BOOL)existsOrCreate:(NSString *)path; //判断目录是否存在，不存在则创建
 
 */
#import "XSYSandbox.h"

@implementation XSYSandbox

+ (NSString *)homePath{
  return NSHomeDirectory();
}


+ (NSString *)appPath
{
  NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
  return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
  NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
  NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
  return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
  NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
  return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

+ (BOOL)existsOrCreate:(NSString *)path
{
  if (![[NSFileManager defaultManager] fileExistsAtPath:path] )
  {
    return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:NULL];
  }
  
  return YES;
}

+ (NSString *)jsPath{
    NSString * path = [NSString stringWithFormat:@"%@/Documents/%@",[self homePath],@"js"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] ){
      return path;
    }
    return nil;
}

+ (NSString *)jsPathExistsOrCreate
{
  NSString * docPath = [self jsPath];
  if ([self existsOrCreate:docPath]) {
    return docPath;
  }
  return nil;
}
@end
