//
//  Diff.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDDiffer : NSObject

+ (NSArray *)characterDifferencesBetweenString:(NSString *)leftString
                                     andString:(NSString *)rightString;

+ (NSArray *)lineDifferencesBetweenString:(NSString *)leftString
                                andString:(NSString *)rightString;

@end
