/*
 * Copyright (c) 2014-2016 Shawn LeMaster
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

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
