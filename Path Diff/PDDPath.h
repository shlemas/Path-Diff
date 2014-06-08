//
//  PDDPath.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/7/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDEdit.h"

@interface PDDPath : NSObject

@property PDDPath *parentDPath;
@property PDEdit *edit;
@property PDEdit *equal;
@property NSInteger x;

- (PDDPath *)clone;

+ (PDDPath *)dPathWithEndXValue:(NSInteger)endXValue;

@end
