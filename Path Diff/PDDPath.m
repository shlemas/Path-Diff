//
//  PDDPath.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/7/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDDPath.h"

@implementation PDDPath

- (id)initWithEndX:(NSInteger)xValue
{
    self = [super init];
    _x = xValue;
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    PDDPath *copy = [[PDDPath allocWithZone:zone] init];
    copy.parentDPath = self.parentDPath;
    copy.edit = self.edit;
    copy.equal = self.equal;
    copy.x = self.x;
    return copy;
}

@end
