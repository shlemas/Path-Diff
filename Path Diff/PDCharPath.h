//
//  PDCharPath.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/9/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDStringPath.h"

@interface PDCharPath : NSObject <PDStringPath>

- (id)initWithString:(NSString *)string;

- (NSString *)stringAtIndex:(NSInteger)index;
- (NSInteger)length;
- (NSString *)string;

@end
