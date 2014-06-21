//
//  PDMainController.h
//  String Diff
//
//  Created by Shawn LeMaster on 6/14/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDFileDiff.h"

@interface PDMainController : NSWindowController

- (id)initWithFileDiff:(PDFileDiff *)fileDiff;

@property PDFileDiff *fileDiff;

@end
