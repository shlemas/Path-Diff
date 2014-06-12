//
//  PDEdit.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/7/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDEdit.h"

@implementation PDEdit

- (id)init
{
    return [self initEditOfType:PD_INVALID withString:@""];
}

- (id)initEditOfType:(PDEditType)type withString:(NSString *)string
{
    self = [super init];
    _type = type;
    _string = [[NSMutableString alloc] initWithString:string];
    return self;
}

+ (PDEdit *)editThatInsertsString:(NSString *)string
{
    return [[PDEdit alloc] initEditOfType:PD_INSERT withString:string];
}

+ (PDEdit *)editThatDeletesString:(NSString *)string
{
    return [[PDEdit alloc] initEditOfType:PD_DELETE withString:string];
}

+ (PDEdit *)editWithEqualString:(NSString *)string
{
    return [[PDEdit alloc] initEditOfType:PD_EQUAL withString:string];
}

@end
