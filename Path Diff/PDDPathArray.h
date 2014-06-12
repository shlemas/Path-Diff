//
//  PDMutableArray.h
//  Path Diff
//
//  Created by Shawn LeMaster on 6/5/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDDPath.h"

@interface PDDPathArray : NSObject

- (id)initWithNumberOfKLines:(NSInteger)numberOfKLines;

- (NSInteger)numberOfKLines;
- (PDDPath *)dPathForKLine:(NSInteger)kLine;
- (void)setDPath:(PDDPath *)dPath forKLine:(NSInteger)kLine;

@end
