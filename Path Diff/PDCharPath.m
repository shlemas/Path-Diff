//
//  PDCharPath.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/9/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDCharPath.h"

@interface PDCharPath ()
@property NSString *chars;
@end

@implementation PDCharPath

- (id)initWithString:(NSString *)string
{
    self = [super init];
    _chars = string;
    return self;
}

- (NSString *)stringAtIndex:(NSInteger)index
{
    const unichar ch = [self.chars characterAtIndex:index];
    return [NSString stringWithCharacters:&ch length:1];
}

- (NSInteger)length
{
    return [self.chars length];
}

- (NSString *)string
{
    return self.chars;
}

@end
