//
//  PDEdit.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/7/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PDEditType) {
    PD_DELETE,
    PD_INSERT,
    PD_EQUAL,

    PD_INVALID
};

@interface PDEdit : NSObject

@property PDEditType type;
@property NSString *string;

+ (PDEdit *)editThatInsertsString:(NSString *)string;
+ (PDEdit *)editThatDeletesString:(NSString *)string;
+ (PDEdit *)editWithEqualString:(NSString *)string;

@end
