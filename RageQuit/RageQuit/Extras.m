//
//  Extras.m
//  RageQuit
//
//  Created by Jonathan Kingsley on 15/02/2015.
//  Copyright (c) 2015 Jonathan Kingsley. All rights reserved.
//

#import "Extras.h"

@implementation Extras
+ (NSMenu*) getMenu {
    NSMenu *menu = [[NSMenu alloc] init];
    
    NSMenuItem *title = [[NSMenuItem alloc] initWithTitle:@"RageQuit" action:nil keyEquivalent:@""];
    NSMenuItem *about = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"about", nil) action:@selector(about) keyEquivalent:@""];
    NSMenuItem *feedback = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"feedback", nil) action:@selector(feedback) keyEquivalent:@""];
    NSMenuItem *quit = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"quit", nil) action:@selector(quit) keyEquivalent:@""];
    
    NSMenuItem *popup = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"popup", nil) action:@selector(changeSetting:) keyEquivalent:@""];
    NSMenuItem *pressAndHold = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"pressAndHold", nil) action:@selector(changeSetting) keyEquivalent:@""];
    NSMenuItem *disableHotkey = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"disableHotkey", nil) action:@selector(changeSetting:) keyEquivalent:@""];
    
    [popup setRepresentedObject:[NSNumber numberWithInt:1]];
    [pressAndHold setRepresentedObject:[NSNumber numberWithInt:2]];
    [disableHotkey setRepresentedObject:[NSNumber numberWithInt:3]];
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"currentSetting"]) {
        case 1:
            [popup setState:NSOnState];
            break;
            
        case 2:
            [pressAndHold setState:NSOnState];
            break;
        
        case 3:
            [disableHotkey setState:NSOnState];
            break;
            
        default:
            [popup setState:NSOnState];
            break;
    }
    
    [menu addItem:title];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:about];
    [menu addItem:feedback];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:popup];
    [menu addItem:pressAndHold];
    [menu addItem:disableHotkey];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:quit];
    
    return menu;
}
@end
