/*
 * Copyright (c) 2014-2016 Shawn LeMaster
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

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
