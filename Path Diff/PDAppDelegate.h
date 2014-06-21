//
//  PDAppDelegate.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "PDFileDiff.h"

@interface PDAppDelegate : NSObject <NSApplicationDelegate>

@property PDFileDiff *fileDiff;

- (IBAction)showOpenFilesSheet:(id)sender;

@end
