//
//  MenuCleaner.m
//  MenuCleaner
//
//  Created by FanFamily on 16/2/2.
//  Copyright © 2016年 glory. All rights reserved.
//

#import "MenuCleaner.h"
#import "MCMenuItem.h"

@interface MenuCleaner()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation MenuCleaner

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    NSMenu *mainMenu = [NSApp mainMenu];

    NSMutableArray* allMenuItems = [[mainMenu itemArray] mutableCopy];
    
    // Xcode menu not add to menu cleaner list
    [allMenuItems removeObjectAtIndex:0];
    
    NSMenuItem *pluginsMenuItem = [mainMenu itemWithTitle:@"Plugins"];
    if (!pluginsMenuItem) {
        pluginsMenuItem = [[NSMenuItem alloc] init];
        pluginsMenuItem.title = @"Plugins";
        pluginsMenuItem.submenu = [[NSMenu alloc] initWithTitle:pluginsMenuItem.title];
        [mainMenu addItem:pluginsMenuItem];
    }
    
    NSMenuItem *mcMenuItem = [[MCMenuItem alloc] initWithMenuItems:allMenuItems];
    [pluginsMenuItem.submenu addItem:mcMenuItem];
}

@end
