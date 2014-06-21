//
//  PDDiffString.h
//  String Diff
//
//  Created by Shawn LeMaster on 6/17/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDMutableDiffString : NSObject

- (id)initWithColor:(NSColor *)color;

- (void)appendCharacter:(unichar)character;
- (void)appendDiffCharacter:(unichar)character;

@property NSMutableAttributedString *string;

@end
