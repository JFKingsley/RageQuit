//
//  Extras.m
//  RageQuit
//
//  Created by Jonathan Kingsley on 15/02/2015.
//  Copyright (c) 2015 Jonathan Kingsley. All rights reserved.
//

#import "Extras.h"

@implementation Extras {
    CFMachPortRef eventTap;
}

BOOL isCmdHeld = NO;

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

- (void) bindKeyEvent {
    NSDictionary *options = @{(id)CFBridgingRelease(kAXTrustedCheckOptionPrompt): @YES};
    BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((CFDictionaryRef)CFBridgingRetain(options));
    
    CFRunLoopSourceRef runLoopSource;
    eventTap = CGEventTapCreate(kCGSessionEventTap, kCGHeadInsertEventTap, kCGEventTapOptionDefault, kCGEventMaskForAllEvents, CGKeypressEventCallback, (__bridge void *)self);
    if (!eventTap) {
        NSLog(@"Couldn't create event tap!");
        exit(1);
    }
    runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
    CGEventTapEnable(eventTap, true);
}

CGEventRef CGKeypressEventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    if ((type != kCGEventKeyDown) && (type != kCGEventKeyUp) && (type != kCGEventFlagsChanged))
        return event;
    //The incoming keycode and bitwise XOR flags to check command
    CGKeyCode keycode = (CGKeyCode) CGEventGetIntegerValueField( event, kCGKeyboardEventKeycode);
    BOOL commandKeyIsPressed = (CGEventGetFlags(event) & kCGEventFlagMaskCommand) == kCGEventFlagMaskCommand;
    
    if(keycode == 12 && commandKeyIsPressed) {
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentSetting"] == 1) {
            NSRunningApplication *currentApp = [[[NSWorkspace sharedWorkspace] activeApplication] objectForKey:@"NSWorkspaceApplicationKey"];
            
            NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"areYouSure", nil)
                                             defaultButton:NSLocalizedString(@"ok", nil)
                                           alternateButton:NSLocalizedString(@"cancel", nil)
                                               otherButton:nil
                                 informativeTextWithFormat:@""];
            NSInteger button = [alert runModal];
            if(button == NSAlertDefaultReturn) {
                [currentApp terminate];
            }
            return NULL;
        }
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentSetting"] == 2) {
            return event;
        }
        
        if([[NSUserDefaults standardUserDefaults] integerForKey:@"currentSetting"] == 3) {
            return NULL;
        }
    }
    
    return event;
}
@end
