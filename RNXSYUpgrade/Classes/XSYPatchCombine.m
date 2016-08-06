//
//  XSYPatchCombine.m
//  ingageplatform
//
//  Created by purple on 16/6/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "XSYPatchCombine.h"
#import "XSYBSDiff.h"
#import "XSYSandbox.h"
#import "XSYJSVersion.h"
static const NSString * indexBundleName = @"index.ios.jsbundle";
@interface XSYPatchCombine()
@property(nonatomic,strong) NSOperationQueue * queue;
@end
@implementation XSYPatchCombine


- (instancetype)init
{
  self = [super init];
  if (self) {
    self.queue = [[NSOperationQueue alloc] init];
  }
  return self;
}


-(void) combineIndexBundle:(NSString *) patchPath newVersion:(NSString *) newVersion
         completionHandler:(void (^)(BOOL success))completionHandler{
    
    NSString * oldVersionPath =[XSYJSVersion getVersionPath:[XSYJSVersion getCurrentVersion]];
    NSString * newVersionPath =[XSYJSVersion getVersionPath:newVersion];
    NSString * oldIndexBundlePath = [NSString stringWithFormat:@"%@/%@",oldVersionPath,indexBundleName];
    NSString * newIndexBundlePath = [NSString stringWithFormat:@"%@/%@",newVersionPath,indexBundleName];
  
    //如果当前版本目录下，存在index.ios.jsbundle,说明已经合并了，不需要再合并了
    if ([[NSFileManager defaultManager] fileExistsAtPath:newIndexBundlePath]){
        if (completionHandler) {
            completionHandler(@NO);
        }
        return;
    }
    //如果当前没有补丁文件直接返回
    if (![[NSFileManager defaultManager] fileExistsAtPath:patchPath]){
        if (completionHandler) {
            completionHandler(@NO);
        }
        return;
    }
    
    NSString * orginPath = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:oldIndexBundlePath]) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.ios" withExtension:@"jsbundle"];
        orginPath  = url.path;
    }else{
        orginPath = oldIndexBundlePath;
    }
    
    
    NSLog(@"源文件路径%@",orginPath);
    NSLog(@"补丁路径%@",patchPath);
    NSLog(@"目标路径%@",newIndexBundlePath);
    [self combine:orginPath patch:patchPath destination:newIndexBundlePath completionHandler:completionHandler];
}

-(void) combine:(NSString *) origin
        patch:(NSString *) patch
        destination:(NSString *) destination
        completionHandler:(void (^)(BOOL success))completionHandler
{
  [self.queue addOperationWithBlock:^{
    BOOL success = [XSYBSDiff bsdiffPatch:patch origin:origin toDestination:destination];
    if (completionHandler) {
      completionHandler(success);
    }
  }];
}
@end
