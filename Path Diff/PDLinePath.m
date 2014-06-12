//
//  PDLinePath.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/9/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDLinePath.h"

@interface PDLinePath ()
@property NSArray *lines;
@end

@implementation PDLinePath

- (id)initWithString:(NSString *)string
{
    self = [super init];
    _lines = [string componentsSeparatedByString:@"\n"];
    return self;
}

- (NSString *)stringAtIndex:(NSInteger)index
{
    NSString *line = [self.lines objectAtIndex:index];

    if (index != [self.lines count] - 1)
        return [line stringByAppendingString:@"\n"];

    return line;
}

- (NSInteger)length
{
    return [self.lines count] - (([[self.lines lastObject] length] == 0) ? 1 : 0);
}

- (NSString *)string
{
    return [self.lines componentsJoinedByString:@"\n"];
}

@end
