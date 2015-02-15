//
//  Extras.h
//  RageQuit
//
//  Created by Jonathan Kingsley on 15/02/2015.
//  Copyright (c) 2015 Jonathan Kingsley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <Carbon/Carbon.h>
#import <ApplicationServices/ApplicationServices.h>

@interface Extras : NSObject

+ (NSMenu*) getMenu;
- (void) bindKeyEvent;

@end
