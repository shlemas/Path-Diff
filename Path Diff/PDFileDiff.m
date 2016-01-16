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

#import "PDFileDiff.h"

#import "PDDiffer.h"
#import "PDEdit.h"
#import "PDMutableDiffString.h"

@implementation PDFileDiff

- (void)updateDiffText
{
    NSString *leftFileContent = [NSString stringWithContentsOfFile:self.leftFilePath
                                                      usedEncoding:nil
                                                             error:NULL];
    NSString *rightFileContent = [NSString stringWithContentsOfFile:self.rightFilePath
                                                       usedEncoding:nil
                                                              error:NULL];
    NSArray *edits = [PDDiffer characterDifferencesBetweenString:leftFileContent
                                                       andString:rightFileContent];

    PDMutableDiffString *leftOutput = [[PDMutableDiffString alloc] initWithColor:[NSColor redColor]];
    PDMutableDiffString *rightOutput = [[PDMutableDiffString alloc] initWithColor:[NSColor greenColor]];

    for (PDEdit *edit in edits) {
        for (NSUInteger i = 0; i < [edit.string length]; i++) {
            unichar character = [edit.string characterAtIndex:i];
            switch (edit.type) {
                case PD_INSERT:
                    [rightOutput appendDiffCharacter:character];
                    break;
                case PD_DELETE:
                    [leftOutput appendDiffCharacter:character];
                    break;
                case PD_EQUAL:
                    [leftOutput appendCharacter:character];
                    [rightOutput appendCharacter:character];
                    break;
                default:
                    break;
            }
        }
    }

    self.leftFileDiffText = leftOutput.string;
    self.rightFileDiffText = rightOutput.string;
}

@end
