//
//  PDUnifiedDiff.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/10/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDEdit.h"

@interface PDUnifiedDiff : NSObject

+ (NSString *)unifiedDiffFromEdits:(NSArray *)edits;

@end
