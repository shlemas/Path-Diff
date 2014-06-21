//
//  PDOpenFilesController.h
//  String Diff
//
//  Created by Shawn LeMaster on 6/15/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDFileDiff.h"

@interface PDOpenFilesController : NSWindowController

- (id)initWithFileDiff:(PDFileDiff *)fileDiff;

- (void)showSheetForWindow:(NSWindow *)window;

- (IBAction)browseForLeftFile:(id)sender;
- (IBAction)browseForRightFile:(id)sender;
- (IBAction)diff:(id)sender;

@property PDFileDiff *fileDiff;
@property (weak) IBOutlet NSTextField *leftFilePathTextField;
@property (weak) IBOutlet NSTextField *rightFilePathTextField;

@end
