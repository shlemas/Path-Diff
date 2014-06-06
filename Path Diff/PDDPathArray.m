//
//  PDMutableArray.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDDPathArray.h"

@interface PDDPathArray ()

@property NSMutableArray *kLinePathArray;

- (NSInteger)getArrayIndexFromKLine:(NSInteger)kLine;

@end

@implementation PDDPathArray

- (id)initWithNumberOfKLines:(NSInteger)numberOfKLines
{
    self = [super init];

    if (self) {
        self.kLinePathArray = [NSMutableArray arrayWithCapacity:numberOfKLines];
        for (NSInteger i = 0; i < numberOfKLines; i++)
            [self.kLinePathArray addObject:[NSNull null]];
    }

    return self;
}

- (NSInteger)numberOfKLines
{
    return (NSInteger)[self.kLinePathArray count];
}

- (NSInteger)xValueForKLine:(NSInteger)kLine
{
    const NSInteger arrayIndex = [self getArrayIndexFromKLine:kLine];
    NSNumber *dPath = [self.kLinePathArray objectAtIndex:arrayIndex];
    return [dPath longValue];
}

- (void)setXValue:(NSInteger)dPath forKLine:(NSInteger)kLine
{
    const NSInteger arrayIndex = [self getArrayIndexFromKLine:kLine];

    [self.kLinePathArray replaceObjectAtIndex:(NSUInteger)arrayIndex
                                   withObject:[NSNumber numberWithLong:dPath]];
}

- (NSInteger)getArrayIndexFromKLine:(NSInteger)kLine
{
    const NSInteger arrayIndex = (kLine + ([self numberOfKLines] / 2));
    assert(arrayIndex >= 0 && arrayIndex < [self numberOfKLines]);
    return arrayIndex;
}

+ (id)dPathArrayWithNumberOfKLines:(NSInteger)numberOfKLines
{
    return [[PDDPathArray alloc] initWithNumberOfKLines:numberOfKLines];
}

@end
