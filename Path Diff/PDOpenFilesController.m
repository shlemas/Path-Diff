//
//  PDOpenFilesController.m
//  String Diff
//
//  Created by Shawn LeMaster on 6/15/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDOpenFilesController.h"

@interface PDOpenFilesController ()

- (void)promptUserToSelectFile:(void (^)(NSString *))completionHandler;

@end

@implementation PDOpenFilesController

- (id)initWithFileDiff:(PDFileDiff *)fileDiff
{
    self = [super initWithWindowNibName:@"OpenFilesSheet"];
    _fileDiff = fileDiff;
    return self;
}

- (void)showSheetForWindow:(NSWindow *)window
{
    [window beginSheet:self.window completionHandler:nil];
}

- (IBAction)browseForLeftFile:(id)sender
{
    [self promptUserToSelectFile:^void (NSString *filePath) { self.leftFilePathTextField.stringValue = filePath; }];
}

- (IBAction)browseForRightFile:(id)sender
{
    [self promptUserToSelectFile:^void (NSString *filePath) { self.rightFilePathTextField.stringValue = filePath; }];
}

- (IBAction)diff:(id)sender
{
    self.fileDiff.leftFilePath = self.leftFilePathTextField.stringValue;
    self.fileDiff.rightFilePath = self.rightFilePathTextField.stringValue;
    [self.fileDiff updateDiffText];

    [self.window orderOut:sender];
}

- (void)promptUserToSelectFile:(void (^)(NSString *))completionHandler
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];

    openPanel.canChooseFiles = YES;
    openPanel.canChooseDirectories = NO;
    openPanel.allowsMultipleSelection = NO;

    [openPanel beginSheetModalForWindow:self.window
                      completionHandler:^void (NSInteger result)
                                         {
                                             if (result == NSFileHandlingPanelOKButton)
                                                 completionHandler(openPanel.URL.path);
                                         }];
}

@end
