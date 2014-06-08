//
//  PDDPath.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/7/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDDPath.h"

@implementation PDDPath

- (id)copyWithZone:(NSZone *)zone
{
    PDDPath *copy = [[PDDPath allocWithZone:zone] init];
    copy.parentDPath = self.parentDPath;
    copy.edit = self.edit;
    copy.equal = self.equal;
    copy.x = self.x;
    return copy;
}

+ (PDDPath *)dPathWithX:(NSInteger)endXValue
{
    PDDPath *dPath = [PDDPath new];
    dPath.x = endXValue;
    return dPath;
}

@end
