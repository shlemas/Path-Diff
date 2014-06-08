//
//  Diff.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDDiff.h"
#import "PDDPathArray.h"
#import "PDDPath.h"

@interface PDDPath ()

+ (NSArray *)solutionEndingWithDPath:(PDDPath *)dPath;

@end

@implementation PDDiff

+ (NSArray *)differencesBetweenString:(NSString *)leftString
                            andString:(NSString *)rightString
{
    const NSInteger N = [leftString length];
    const NSInteger M = [rightString length];

    if (N == 0 && M != 0)
        return [NSArray arrayWithObject:[PDEdit editThatInsertsString:rightString]];

    if (M == 0 && N != 0)
        return [NSArray arrayWithObject:[PDEdit editThatDeletesString:leftString]];

    const NSInteger MAX = N + M;

    if (MAX > 0) {
        PDDPathArray *V = [PDDPathArray dPathArrayWithNumberOfKLines:(MAX * 2)];

        [V setDPath:[PDDPath dPathWithEndXValue:0] forKLine:1];

        for (NSInteger D = 0; D <= MAX; D++) {
            for (NSInteger k = -D; k <= D; k += 2) {
                PDDPath *dPath = [PDDPath new];
                PDEditType editType = PD_INVALID;
                NSInteger y;

                if (k == -D || (k != D && [V dPathForKLine:(k + 1)].x >= [V dPathForKLine:(k - 1)].x)) {
                    PDDPath *parentDPath = [V dPathForKLine:(k + 1)];
                    dPath.parentDPath = [parentDPath clone];
                    dPath.x = parentDPath.x;
                    editType = PD_INSERT;
                } else {
                    PDDPath *parentDPath = [V dPathForKLine:(k - 1)];
                    dPath.parentDPath = [parentDPath clone];
                    dPath.x = parentDPath.x + 1;
                    editType = PD_DELETE;
                }

                y = dPath.x - k;

                if (D > 0) {
                    if (editType == PD_INSERT && (y - 1) < M) {
                        const unichar insertedChar = [rightString characterAtIndex:(y - 1)];
                        NSString *insertedStr = [NSString stringWithCharacters:&insertedChar length:1];
                        dPath.edit = [PDEdit editThatInsertsString:insertedStr];
                    } else if (editType == PD_DELETE && (dPath.x - 1) < N) {
                        const unichar deletedChar = [leftString characterAtIndex:(dPath.x - 1)];
                        NSString *deletedStr = [NSString stringWithCharacters:&deletedChar length:1];
                        dPath.edit = [PDEdit editThatDeletesString:deletedStr];
                    }
                }

                NSMutableString *equalStr = [NSMutableString string];
                while (dPath.x < N && y < M && [leftString characterAtIndex:dPath.x] == [rightString characterAtIndex:y]) {
                    const unichar equalChar = [leftString characterAtIndex:dPath.x];
                    [equalStr appendString:[NSString stringWithCharacters:&equalChar length:1]];
                    dPath.x++;
                    y++;
                }

                if ([equalStr length] > 0)
                    dPath.equal = [PDEdit editWithEqualString:equalStr];

                if (dPath.x == N && y == M)
                    return [PDDiff solutionEndingWithDPath:dPath];

                [V setDPath:dPath forKLine:k];
            }
        }
    }

    return [NSArray arrayWithObject:[PDEdit editWithEqualString:@""]];
}

+ (NSArray *)solutionEndingWithDPath:(PDDPath *)dPath
{
    NSMutableArray *edits = [NSMutableArray array];

    while (dPath.parentDPath) {
        if (dPath.equal)
            [edits insertObject:dPath.equal atIndex:0];

        if (dPath.edit) {
            PDEdit *prevEdit = ([edits count] > 0) ? [edits firstObject] : nil;
            if (prevEdit && (prevEdit.type == dPath.edit.type))
                prevEdit.string = [dPath.edit.string stringByAppendingString:prevEdit.string];
            else
                [edits insertObject:dPath.edit atIndex:0];
        }

        dPath = dPath.parentDPath;
    }

    return edits;
}

@end
