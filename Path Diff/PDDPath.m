//
//  PDDPath.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/7/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDDPath.h"

@implementation PDDPath

- (PDDPath *)clone
{
    PDDPath *copy = [PDDPath dPathWithEndXValue:self.x];
    copy.parentDPath = self.parentDPath;
    copy.edit = self.edit;
    copy.equal = self.equal;
    return copy;
}

+ (PDDPath *)dPathWithEndXValue:(NSInteger)endXValue
{
    PDDPath *dPath = [PDDPath new];
    dPath.x = endXValue;
    return dPath;
}

@end