//
//  PDAppDelegate.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PDAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *leftTextField;
@property (weak) IBOutlet NSTextField *rightTextField;
@property (unsafe_unretained) IBOutlet NSTextView *diffTextView;

- (void)controlTextDidChange:(NSNotification *)aNotification;

@end
