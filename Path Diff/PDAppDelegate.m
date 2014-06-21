//
//  PDAppDelegate.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDAppDelegate.h"

#import "PDMainController.h"
#import "PDOpenFilesController.h"

@interface PDAppDelegate ()

@property PDMainController *mainController;
@property PDOpenFilesController *openFilesController;

@end

@implementation PDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.fileDiff = [[PDFileDiff alloc] init];
    self.mainController = [[PDMainController alloc] initWithFileDiff:self.fileDiff];
    self.openFilesController = [[PDOpenFilesController alloc] initWithFileDiff:self.fileDiff];

    [self.mainController showWindow:self];
    [self showOpenFilesSheet:self];
}

- (IBAction)showOpenFilesSheet:(id)sender
{
    [self.openFilesController showSheetForWindow:self.mainController.window];
}

@end
