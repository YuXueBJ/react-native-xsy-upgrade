//
//  XSYPatchCombine.h
//  ingageplatform
//
//  Created by purple on 16/6/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSYPatchCombine : NSObject
-(void) combineIndexBundle:(NSString *) patchPath newVersion:(NSString *) newVersion
         completionHandler:(void (^)(BOOL success))completionHandler;
@end
