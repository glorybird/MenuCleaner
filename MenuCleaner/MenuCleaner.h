//
//  MenuCleaner.h
//  MenuCleaner
//
//  Created by FanFamily on 16/2/2.
//  Copyright © 2016年 glory. All rights reserved.
//

#import <AppKit/AppKit.h>

@class MenuCleaner;

static MenuCleaner *sharedPlugin;

@interface MenuCleaner : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end