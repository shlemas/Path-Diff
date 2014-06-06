//
//  Diff.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDDiff : NSObject

- (NSInteger)differenceBetweenString:(NSString *)leftString
                           andString:(NSString *)rightString;

@end
