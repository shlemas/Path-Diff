//
//  PDAppDelegate.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDAppDelegate.h"
#import "PDDiff.h"
#import "PDEdit.h"

@implementation PDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
    NSArray *edits = [PDDiff differencesBetweenString:[self.leftTextField stringValue]
                                            andString:[self.rightTextField stringValue]];

    NSMutableAttributedString *diffOutput = [NSMutableAttributedString new];

    for (PDEdit *edit in edits) {
        switch (edit.type) {
            case PD_INSERT: {
                NSColor *color = [[NSColor greenColor] highlightWithLevel:0.8];
                NSDictionary *attrs = @{ NSBackgroundColorAttributeName: color };
                [diffOutput appendAttributedString:[[NSAttributedString alloc] initWithString:edit.string
                                                                                   attributes:attrs]];
                break;
            }

            case PD_DELETE: {
                NSColor *color = [[NSColor redColor] highlightWithLevel:0.8];
                NSDictionary *attrs = @{ NSBackgroundColorAttributeName: color,
                                         NSStrikethroughStyleAttributeName: @(1) };
                [diffOutput appendAttributedString:[[NSAttributedString alloc] initWithString:edit.string
                                                                                   attributes:attrs]];
                break;
            }

            case PD_EQUAL:
                [diffOutput appendAttributedString:[[NSAttributedString alloc] initWithString:edit.string]];
                break;

            default:
                break;
        }
    }

    [[self.diffTextView textStorage] setAttributedString:diffOutput];
}

@end
