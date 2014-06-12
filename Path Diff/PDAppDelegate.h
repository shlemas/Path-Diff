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
@property (unsafe_unretained) IBOutlet NSTextView *diffTextView;
@property (unsafe_unretained) IBOutlet NSTextView *leftTextView;
@property (unsafe_unretained) IBOutlet NSTextView *rightTextView;
@property (weak) IBOutlet NSMatrix *diffTypeRadioButtons;

- (void)textDidChange:(NSNotification *)aNotification;
- (IBAction)diffTypeChanged:(NSMatrix *)sender;
- (IBAction)diffDisplayChanged:(NSMatrix *)sender;

@end
