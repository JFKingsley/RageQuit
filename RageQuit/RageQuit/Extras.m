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
    
    [menu addItem:title];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:about];
    [menu addItem:feedback];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItem:quit];
    
    return menu;
}
@end
