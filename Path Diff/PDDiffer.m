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

#import "PDDiffer.h"
#import "PDDPathArray.h"
#import "PDDPath.h"
#import "PDStringPath.h"
#import "PDCharPath.h"
#import "PDLinePath.h"

@interface PDDPath ()

+ (NSArray *)differencesBetweenObject:(id <PDStringPath>)leftObject
                            andObject:(id <PDStringPath>)rightObject;

+ (NSArray *)solutionEndingWithDPath:(PDDPath *)dPath;

@end

@implementation PDDiffer

+ (NSArray *)differencesBetweenObject:(id <PDStringPath>)leftObject
                            andObject:(id <PDStringPath>)rightObject
{
    const NSInteger N = [leftObject length];
    const NSInteger M = [rightObject length];

    if (N > 0 && M > 0) {
        const NSInteger MAX = N + M;
        PDDPathArray *V = [[PDDPathArray alloc] initWithNumberOfKLines:((MAX * 2) + 1)];

        [V setDPath:[[PDDPath alloc] initWithEndX:0] forKLine:1];

        for (NSInteger D = 0; D <= MAX; D++) {
            for (NSInteger k = -D; k <= D; k += 2) {
                PDDPath *dPath = [[PDDPath alloc] init];
                NSInteger y;
                PDEditType editType;
                NSMutableString *equalString = [[NSMutableString alloc] init];

                if (k == -D || (k != D && [V dPathForKLine:(k + 1)].x > [V dPathForKLine:(k - 1)].x)) {
                    dPath.parentDPath = [[V dPathForKLine:(k + 1)] copy];
                    dPath.x = dPath.parentDPath.x;
                    editType = PD_INSERT;
                } else {
                    dPath.parentDPath = [[V dPathForKLine:(k - 1)] copy];
                    dPath.x = dPath.parentDPath.x + 1;
                    editType = PD_DELETE;
                }

                y = dPath.x - k;

                if (D > 0) {
                    if (editType == PD_INSERT && (y - 1) < M)
                        dPath.edit = [PDEdit editThatInsertsString:[rightObject stringAtIndex:(y - 1)]];
                    else if (editType == PD_DELETE && (dPath.x - 1) < N)
                        dPath.edit = [PDEdit editThatDeletesString:[leftObject stringAtIndex:(dPath.x - 1)]];
                }

                while (dPath.x < N && y < M && [[leftObject stringAtIndex:dPath.x] isEqualToString:[rightObject stringAtIndex:y]]) {
                    [equalString appendString:[leftObject stringAtIndex:dPath.x]];
                    dPath.x++;
                    y++;
                }

                if ([equalString length] > 0)
                    dPath.equal = [PDEdit editWithEqualString:equalString];

                if (dPath.x == N && y == M)
                    return [PDDiffer solutionEndingWithDPath:dPath];

                [V setDPath:dPath forKLine:k];
            }
        }
    }

    if (N == 0 && M != 0)
        return [NSArray arrayWithObject:[PDEdit editThatInsertsString:[rightObject string]]];

    if (M == 0 && N != 0)
        return [NSArray arrayWithObject:[PDEdit editThatDeletesString:[leftObject string]]];

    return [NSArray arrayWithObject:[PDEdit editWithEqualString:@""]];
}

+ (NSArray *)characterDifferencesBetweenString:(NSString *)leftString
                                     andString:(NSString *)rightString
{
    return [PDDiffer differencesBetweenObject:[[PDCharPath alloc] initWithString:leftString]
                                    andObject:[[PDCharPath alloc] initWithString:rightString]];
}

+ (NSArray *)lineDifferencesBetweenString:(NSString *)leftString
                                andString:(NSString *)rightString
{
    return [PDDiffer differencesBetweenObject:[[PDLinePath alloc] initWithString:leftString]
                                    andObject:[[PDLinePath alloc] initWithString:rightString]];
}

+ (NSArray *)solutionEndingWithDPath:(PDDPath *)dPath
{
    NSMutableArray *edits = [NSMutableArray array];

    while (dPath.parentDPath) {
        if (dPath.equal)
            [edits insertObject:dPath.equal atIndex:0];

        if (dPath.edit) {
            PDEdit *prevEdit = [edits firstObject];
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
