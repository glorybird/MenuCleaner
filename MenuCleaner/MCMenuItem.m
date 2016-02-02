//
//  MainMenuItem.m
//  MenuCleaner
//
//  Created by FanFamily on 16/2/2.
//  Copyright © 2016年 glory. All rights reserved.
//

#import "MCMenuItem.h"

@interface MCMenuItem ()

@property (nonatomic) NSArray* items;
@property (nonatomic) NSUserDefaults* config;

@end

@implementation MCMenuItem

- (instancetype)initWithMenuItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.title = @"Menu Cleaner";
        
        NSMenu *configMenu = [[NSMenu alloc] init];
        self.submenu = configMenu;
        
        self.items = items;
        
        self.config = [[NSUserDefaults alloc] initWithSuiteName:@"com.glorybird.mc"];
        
        [self.items enumerateObjectsUsingBlock:^(NSMenuItem*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.title isEqualToString:self.title]) {
                return ;
            }
            NSMenuItem* menuItem = [NSMenuItem new];
            menuItem.title = obj.title;
            menuItem.tag = idx;
            NSNumber* state = [self.config objectForKey:menuItem.title];
            if (state) {
                menuItem.state = state.integerValue;
                if (state.integerValue == NSOffState) {
                    [[NSApp mainMenu] removeItem:obj];
                }
            } else {
                menuItem.state = NSOnState;
            }
            menuItem.target = self;
            menuItem.action = @selector(clickMenuItem:);
            [configMenu addItem:menuItem];
        }];
    }
    return self;
}

- (void)clickMenuItem:(NSMenuItem *)menuItem
{
    menuItem.state = menuItem.state == NSOnState ? NSOffState:NSOnState;
    [self.config setObject:@(menuItem.state) forKey:menuItem.title];
    [self.config synchronize];
    NSMenuItem* realMenu = [self.items objectAtIndex:menuItem.tag];
    if (realMenu) {
        if (menuItem.state == NSOffState) {
            [[NSApp mainMenu] removeItem:realMenu];
        } else {
            [[NSApp mainMenu] addItem:realMenu];
        }
    }
}

@end
