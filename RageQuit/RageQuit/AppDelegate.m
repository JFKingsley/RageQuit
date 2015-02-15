//
//  AppDelegate.m
//  RageQuit
//
//  Created by Jonathan Kingsley on 15/02/2015.
//  Copyright (c) 2015 Jonathan Kingsley. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setTitle:@""];
    [statusItem setImage:[NSImage imageNamed:@"MenuIcon"]];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:[Extras getMenu]];
    
    Extras *extras = [[Extras alloc] init];
    [extras bindKeyEvent];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void) about {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"https://github.com/JFKingsley/RageQuit"]];
}

- (void) feedback {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: @"https://github.com/JFKingsley/RageQuit/issues"]];
}

- (void) changeSetting: (id) menuItem {
    [[NSUserDefaults standardUserDefaults] setInteger:[(NSNumber *)[(NSMenuItem *)menuItem representedObject] integerValue] forKey:@"currentSetting"];
    [statusItem setMenu:[Extras getMenu]];
}

- (void) quit {
    [NSApp terminate:self];
}

@end
