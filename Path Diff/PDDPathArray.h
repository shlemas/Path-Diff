//
//  PDMutableArray.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDDPathArray : NSObject

- (id)initWithNumberOfKLines:(NSInteger)numberOfKLines;

- (NSInteger)numberOfKLines;
- (NSInteger)xValueForKLine:(NSInteger)kLine;
- (void)setXValue:(NSInteger)dPath forKLine:(NSInteger)kLine;

+ (id)dPathArrayWithNumberOfKLines:(NSInteger)numberOfKLines;

@end
