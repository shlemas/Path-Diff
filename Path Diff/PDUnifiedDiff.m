//
//  PDUnifiedDiff.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/10/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDUnifiedDiff.h"

@implementation PDUnifiedDiff

+ (NSString *)unifiedDiffFromEdits:(NSArray *)edits
{
    NSMutableString *diffText = [NSMutableString string];
    BOOL inChunk = NO;
    NSMutableString *chunkString = [NSMutableString string];
    NSUInteger fromLineNumber = 1;
    NSUInteger toLineNumber = 1;
    NSUInteger chunkFromLineNumberCount = 0;
    NSUInteger chunkToLineNumberCount = 0;

    [diffText appendString:@"--- from-file 2014-06-09 10:46:30.849174605 -0600\n"
                            "+++ to-file 2014-06-10 16:14:39.942229878 -0600\n"];

    for (PDEdit *edit in edits) {
        NSArray *lines = [edit.string componentsSeparatedByString:@"\n"];
        const BOOL emptyLastLine = ([[lines lastObject] length] == 0);
        const NSUInteger numberOfLines = [lines count] - (emptyLastLine ? 1 : 0);
        switch (edit.type) {
            case PD_DELETE:
                for (NSUInteger i = 0; i < numberOfLines; i++)
                    [chunkString appendFormat:@"-%@\n", [lines objectAtIndex:i]];
                chunkFromLineNumberCount += numberOfLines;
                inChunk = YES;
                break;
            case PD_INSERT:
                for (NSUInteger i = 0; i < numberOfLines; i++)
                    [chunkString appendFormat:@"+%@\n", [lines objectAtIndex:i]];
                chunkToLineNumberCount += numberOfLines;
                inChunk = YES;
                break;
            case PD_EQUAL:
            default:
                if (inChunk) {
                    NSMutableString *chunkHeader = [NSMutableString stringWithString:@"@@ "];

                    [chunkHeader appendFormat:@"%lu", (unsigned long)fromLineNumber];
                    if (chunkFromLineNumberCount > 1)
                        [chunkHeader appendFormat:@",%lu", (unsigned long)chunkFromLineNumberCount];

                    [chunkHeader appendFormat:@" %lu", (unsigned long)toLineNumber];
                    if (chunkToLineNumberCount > 1)
                        [chunkHeader appendFormat:@",%lu", (unsigned long)chunkToLineNumberCount];

                    [chunkHeader appendString:@" @@\n"];

                    [chunkString insertString:chunkHeader atIndex:0];
                    fromLineNumber += chunkFromLineNumberCount;
                    toLineNumber += chunkToLineNumberCount;
                    chunkFromLineNumberCount = 0;
                    chunkToLineNumberCount = 0;
                    [diffText appendString:chunkString];
                    [chunkString setString:@""];
                }
                fromLineNumber += numberOfLines;
                toLineNumber += numberOfLines;
                break;
        }
    }

    return diffText;
}

@end
