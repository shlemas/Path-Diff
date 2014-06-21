//
//  PDDiff.m
//  String Diff
//
//  Created by Shawn LeMaster on 6/19/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

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
