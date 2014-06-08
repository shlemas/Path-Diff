//
//  PDEdit.m
//  Path Diff
//
//  Created by Shawn LeMaster on 6/7/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDEdit.h"

@interface PDEdit ()

+ (id)editOfType:(PDEditType)type withString:(NSString *)string;

@end

@implementation PDEdit

+ (id)editOfType:(PDEditType)type withString:(NSString *)string
{
    PDEdit *edit = [PDEdit new];
    edit.type = type;
    edit.string = string;
    return edit;
}

+ (PDEdit *)editThatInsertsString:(NSString *)string
{
    return [PDEdit editOfType:PD_INSERT withString:string];
}

+ (PDEdit *)editThatDeletesString:(NSString *)string
{
    return [PDEdit editOfType:PD_DELETE withString:string];
}

+ (PDEdit *)editWithEqualString:(NSString *)string
{
    return [PDEdit editOfType:PD_EQUAL withString:string];
}

@end
