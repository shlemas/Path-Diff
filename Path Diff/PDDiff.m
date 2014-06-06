//
//  Diff.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDDiff.h"
#import "PDDPathArray.h"

@implementation PDDiff

- (NSInteger)differenceBetweenString:(NSString *)leftString
                           andString:(NSString *)rightString
{
    const NSInteger N = [leftString length];
    const NSInteger M = [rightString length];
    const NSInteger MAX = N + M;

    if (MAX > 0) {
        PDDPathArray *V = [PDDPathArray dPathArrayWithNumberOfKLines:(MAX * 2)];

        [V setXValue:0 forKLine:1];

        for (NSInteger D = 0; D <= MAX; D++) {
            for (NSInteger k = -D; k <= D; k += 2) {
                NSInteger x, y;

                if (k == -D || (k != D && [V xValueForKLine:(k + 1)] >= [V xValueForKLine:(k - 1)]))
                    x = [V xValueForKLine:(k + 1)];
                else
                    x = [V xValueForKLine:(k - 1)] + 1;

                y = x - k;

                while (x < N && y < M && [leftString characterAtIndex:x] == [rightString characterAtIndex:y]) {
                    x++;
                    y++;
                }

                if (x == N && y == M) {
                    NSLog(@"There are %ld differences.\n", (long)D);
                    return D;
                }

                [V setXValue:x forKLine:k];
            }
        }
    }

    return 0;
}

@end
