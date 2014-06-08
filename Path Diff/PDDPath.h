//
//  PDDPath.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/7/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDEdit.h"

@interface PDDPath : NSObject <NSCopying>

@property PDDPath *parentDPath;
@property PDEdit *edit;
@property PDEdit *equal;
@property NSInteger x;

- (id)copyWithZone:(NSZone *)zone;

+ (PDDPath *)dPathWithX:(NSInteger)endXValue;

@end
