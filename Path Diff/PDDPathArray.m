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

#import "PDDPathArray.h"

@interface PDDPathArray ()

- (NSUInteger)arrayIndexForKLine:(NSInteger)kLine;

@property NSMutableArray *kLinePathArray;

@end

@implementation PDDPathArray

- (id)initWithNumberOfKLines:(NSInteger)numberOfKLines
{
    self = [super init];
    _kLinePathArray = [NSMutableArray arrayWithCapacity:numberOfKLines];
    for (NSInteger i = 0; i < numberOfKLines; i++)
        [_kLinePathArray addObject:[NSNull null]];
    return self;
}

- (NSInteger)numberOfKLines
{
    return (NSInteger)[self.kLinePathArray count];
}

- (PDDPath *)dPathForKLine:(NSInteger)kLine
{
    return [self.kLinePathArray objectAtIndex:[self arrayIndexForKLine:kLine]];
}

- (void)setDPath:(PDDPath *)dPath forKLine:(NSInteger)kLine
{
    [self.kLinePathArray replaceObjectAtIndex:[self arrayIndexForKLine:kLine]
                                   withObject:dPath];
}

- (NSUInteger)arrayIndexForKLine:(NSInteger)kLine
{
    const NSInteger arrayIndex = (kLine + ([self numberOfKLines] / 2));
    assert(arrayIndex >= 0 && arrayIndex < [self numberOfKLines]);
    return (NSUInteger)arrayIndex;
}

@end
