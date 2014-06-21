//
//  PDMainController.m
//  String Diff
//
//  Created by Shawn LeMaster on 6/14/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDMainController.h"

@implementation PDMainController

- (id)initWithFileDiff:(PDFileDiff *)fileDiff
{
    self = [super initWithWindowNibName:@"MainWindow"];
    _fileDiff = fileDiff;
    return self;
}

@end
