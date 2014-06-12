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
#import "PDUnifiedDiff.h"

@interface PDAppDelegate ()

@property SEL differencesBetweenString;
@property SEL displayDiff;

- (void)updateDiff;
- (void)updateColoredDiff;
- (void)updateUnifiedDiff;

@end

@implementation PDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.differencesBetweenString = @selector(characterDifferencesBetweenString:andString:);
    self.displayDiff = @selector(updateColoredDiff);
}

- (void)textDidChange:(NSNotification *)aNotification
{
    [self updateDiff];
}

- (IBAction)diffTypeChanged:(NSMatrix *)sender
{
    NSButtonCell *selectedDiffType = [sender selectedCell];

    if ([[selectedDiffType title] isEqualToString:@"Characters"])
        self.differencesBetweenString = @selector(characterDifferencesBetweenString:andString:);
    else if ([[selectedDiffType title] isEqualToString:@"Lines"])
        self.differencesBetweenString = @selector(lineDifferencesBetweenString:andString:);

    [self updateDiff];
}

- (IBAction)diffDisplayChanged:(NSMatrix *)sender
{
    NSButtonCell *selectedDiffType = [sender selectedCell];

    if ([[selectedDiffType title] isEqualToString:@"Colored text"])
        self.displayDiff = @selector(updateColoredDiff);
    else if ([[selectedDiffType title] isEqualToString:@"Unified diff"])
        self.displayDiff = @selector(updateUnifiedDiff);

    [self updateDiff];
}

- (void)updateDiff
{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:self.displayDiff]];
    invocation.target = self;
    invocation.selector = self.displayDiff;
    [invocation invoke];
}

- (void)updateColoredDiff
{
    NSArray *edits = [PDDiff performSelector:self.differencesBetweenString
                                  withObject:[[self.leftTextView textStorage] string]
                                  withObject:[[self.rightTextView textStorage] string]];

    NSMutableAttributedString *diffOutput = [[NSMutableAttributedString alloc] init];

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
                NSDictionary *attrs = @{ NSBackgroundColorAttributeName: color };
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

- (void)updateUnifiedDiff
{
    NSArray *edits = [PDDiff lineDifferencesBetweenString:[[self.leftTextView textStorage] string]
                                                andString:[[self.rightTextView textStorage] string]];
    NSAttributedString *diffText = [[NSAttributedString alloc] initWithString:[PDUnifiedDiff unifiedDiffFromEdits:edits]];

    [[self.diffTextView textStorage] setAttributedString:diffText];
}

@end
