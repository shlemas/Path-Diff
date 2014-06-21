//
//  PDDiff.h
//  String Diff
//
//  Created by Shawn LeMaster on 6/19/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFileDiff : NSObject

- (void)updateDiffText;

@property NSString *leftFilePath;
@property NSString *rightFilePath;

@property NSAttributedString *leftFileDiffText;
@property NSAttributedString *rightFileDiffText;

@end
