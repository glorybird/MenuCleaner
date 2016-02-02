//
//  NSObject_Extension.m
//  MenuCleaner
//
//  Created by FanFamily on 16/2/2.
//  Copyright © 2016年 glory. All rights reserved.
//


#import "NSObject_Extension.h"
#import "MenuCleaner.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[MenuCleaner alloc] initWithBundle:plugin];
        });
    }
}
@end
