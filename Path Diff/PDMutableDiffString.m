//
//  PDDiffString.m
//  String Diff
//
//  Created by Shawn LeMaster on 6/17/14.
//  Copyright (c) 2014 Shawn LeMaster. All rights reserved.
//

#import "PDMutableDiffString.h"

@interface PDMutableDiffString ()

+ (NSString *)stringFromCharacter:(unichar)character;

- (void)colorCurrentCharWithColor:(NSColor *)color;
- (void)colorCurrentLineWithColor:(NSColor *)color;
- (void)propagateCurrentLineColorWithColor:(NSColor *)color;

@property NSColor *charBackgroundColor;
@property NSColor *lineBackgroundColor;

@end

@implementation PDMutableDiffString

- (id)initWithColor:(NSColor *)color
{
    self = [super init];
    _string = [[NSMutableAttributedString alloc] init];
    _charBackgroundColor = [color highlightWithLevel:0.6];
    _lineBackgroundColor = [color highlightWithLevel:0.9];
    return self;
}

- (void)appendCharacter:(unichar)character
{
    [self.string appendAttributedString:[[NSAttributedString alloc] initWithString:[PDMutableDiffString stringFromCharacter:character]]];
    [self propagateCurrentLineColorWithColor:self.lineBackgroundColor];
}

- (void)appendDiffCharacter:(unichar)character
{
    [self appendCharacter:character];
    [self colorCurrentLineWithColor:self.lineBackgroundColor];
    [self colorCurrentCharWithColor:self.charBackgroundColor];
}

+ (NSString *)stringFromCharacter:(unichar)character
{
    return [NSString stringWithCharacters:&character length:1];
}

- (void)colorCurrentCharWithColor:(NSColor *)color
{
    NSRange colorRange;
    colorRange.location = self.string.length - 1;
    colorRange.length = 1;

    [self.string addAttributes:@{ NSBackgroundColorAttributeName: color } range:colorRange];
}

- (void)colorCurrentLineWithColor:(NSColor *)color
{
    NSRange colorRange;
    colorRange.location = self.string.length;
    colorRange.length = 0;

    for (NSInteger i = colorRange.location - 1; i >= 0; i--) {
        if (([self.string.string characterAtIndex:i] == '\n') || [self.string attribute:NSBackgroundColorAttributeName atIndex:i effectiveRange:NULL])
            break;
        colorRange.location--;
        colorRange.length++;
    }

    [self.string addAttributes:@{ NSBackgroundColorAttributeName: color } range:colorRange];
}

- (void)propagateCurrentLineColorWithColor:(NSColor *)color
{
    const NSUInteger lastCharacterIndex = self.string.length - 1;

    if (lastCharacterIndex > 0) {
        const NSUInteger prevCharacterIndex = lastCharacterIndex - 1;
        NSColor *backgroundColor = [self.string attribute:NSBackgroundColorAttributeName atIndex:prevCharacterIndex effectiveRange:NULL];
        if (([self.string.string characterAtIndex:prevCharacterIndex] != '\n') && backgroundColor)
            [self colorCurrentCharWithColor:color];
    }
}

@end
