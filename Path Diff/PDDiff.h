//
//  Diff.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDDiff : NSObject

+ (NSArray *)differencesBetweenString:(NSString *)leftString
                            andString:(NSString *)rightString;

@end
