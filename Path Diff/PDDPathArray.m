//
//  PDMutableArray.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

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
