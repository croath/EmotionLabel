//
//  EmotionLabel.m
//  EmotionLabel
//
//  Created by croath on 11/6/13.
//  Copyright (c) 2013 Croath. All rights reserved.
//

#import "EmotionLabel.h"
#import <CoreText/CoreText.h>
#import <UIKit/NSText.h>

#define PATTERN_STR         @"\\[[^\\[\\]]*\\]"

@interface EmotionLabel(){
    NSMutableAttributedString *_attributeString;
    CTFrameRef _textFrame;
	CGRect _drawingRect;
    NSMutableArray *_images;
    NSMutableArray *_imageInfoArr;
    NSMutableArray *_imageNames;
    NSDictionary *_matchDict;
    CGFloat _fixedHeight;
}

@property (nonatomic, strong) NSDictionary* imgAttr;

@end

@implementation EmotionLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    
    if (_textFrame != NULL) {
        CFRelease(_textFrame);
        _textFrame = NULL;
    }
    _images = [NSMutableArray array];
    _imageInfoArr = [NSMutableArray array];
    _imageNames = [NSMutableArray array];
    
    _attributeString = [[NSMutableAttributedString alloc] initWithString:@""];
    [self decoratedString:text];
}

- (void)setMatchArray:(NSArray *)matchArray{
    _matchArray = matchArray;
    _matchDict = [self.class matchDictWithArray:_matchArray];
}


- (void)decoratedString:(NSString*)string{
    NSRegularExpression* regex = [[NSRegularExpression alloc]
                                  initWithPattern:PATTERN_STR
                                  options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                  error:nil];
    NSArray* chunks = [regex matchesInString:string options:0
                                       range:NSMakeRange(0, [string length])];
    NSMutableArray *matchRanges = [NSMutableArray array];
    
    for (NSTextCheckingResult *result in chunks) {
        NSString *resultStr = [string substringWithRange:[result range]];
        if ([resultStr hasPrefix:@"["] && [resultStr hasSuffix:@"]"]) {
            NSString *name = [resultStr substringWithRange:NSMakeRange(1, [resultStr length]-2)];
            if ([[_matchDict allKeys] containsObject:name]) {
                [_imageNames addObject:name];
                [matchRanges addObject:[NSValue valueWithRange:result.range]];
            }
        }
    }
    
    NSRange r = NSMakeRange([string length], 0);
    [matchRanges addObject:[NSValue valueWithRange:r]];
    
    NSUInteger lastLoc = 0;
    for (NSValue *v in matchRanges) {
        NSRange resultRange = [v rangeValue];
        NSRange normalStringRange = NSMakeRange(lastLoc, resultRange.location - lastLoc);
        NSString *normalString = [string substringWithRange:normalStringRange];
        lastLoc = resultRange.location + resultRange.length;
        
        [self basicAttributesWithString:normalString withImage:![v isEqual:[matchRanges lastObject]]];
    }
}

- (void)basicAttributesWithString:(NSString*)string withImage:(BOOL)hasImage{
    if (hasImage) {
        string = [string stringByAppendingString:@" "];
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    CTTextAlignment alignment = (uint8_t)self.textAlignment;
    CTLineBreakMode lineBreakMode = (uint8_t)self.lineBreakMode;
	CTParagraphStyleSetting paraStyles[2] =
    {
		{
            .spec = kCTParagraphStyleSpecifierAlignment,
            .valueSize = sizeof(CTTextAlignment),
            .value = (const void*)&alignment
        },
        {
            .spec = kCTParagraphStyleSpecifierLineBreakMode,
            .valueSize = sizeof(CTLineBreakMode),
            .value = (const void*)&lineBreakMode
        }
	};
	CTParagraphStyleRef aStyle = CTParagraphStyleCreate(paraStyles, 2);
    
    NSRange fullRange = NSMakeRange(0, [string length]);
	[attrString removeAttribute:(NSString*)kCTParagraphStyleAttributeName
                          range:fullRange];
	[attrString addAttribute:(NSString*)kCTParagraphStyleAttributeName
                       value:(__bridge id)aStyle
                       range:fullRange];
    
    [attrString removeAttribute:(NSString*)kCTFontAttributeName range:fullRange];
    CTFontRef aFont = CTFontCreateWithName((CFStringRef)self.font.fontName, self.font.pointSize, NULL);
	[attrString addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)aFont range:fullRange];
    CFRelease(aFont);
	CFRelease(aStyle);
    
    __block NSNumber* width = [NSNumber numberWithInt:self.font.lineHeight];
    __block NSNumber* height = [NSNumber numberWithInt:self.font.lineHeight];
    
    [_images addObject:
     [NSDictionary dictionaryWithObjectsAndKeys:
      width, @"width",
      height, @"height",
      [NSNumber numberWithUnsignedInteger:[_attributeString length] + [attrString length]-1], @"location",
      nil]
     ];
    
    CTRunDelegateCallbacks callbacks;
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    callbacks.dealloc = deallocCallback;
    
    _imgAttr = [[NSDictionary alloc] initWithObjectsAndKeys:
                             width, @"width",
                             height, @"height", nil];
    
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge_retained void *)(_imgAttr));
    NSDictionary *attrDictionaryDelegate = [NSDictionary dictionaryWithObjectsAndKeys:
                                            (__bridge id)delegate, (NSString*)kCTRunDelegateAttributeName,
                                            nil];
    CFRelease(delegate);
    
    if ([string length] < 1) {
        return;
    }
    if (hasImage) {
        [attrString addAttributes:attrDictionaryDelegate
                            range:NSMakeRange([string length] - 1, 1)];
    }
    
    [_attributeString appendAttributedString:attrString];
}

/* Callbacks */
static void deallocCallback( void* ref ){
//    ref = [[NSDictionary alloc] init];
    //    [(__bridge id)ref release];
    ref = nil;
}
static CGFloat ascentCallback( void *ref ){
    return [(NSString*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallback( void *ref ){
    return [(NSString*)[(__bridge NSDictionary*)ref objectForKey:@"descent"] floatValue];
}
static CGFloat widthCallback( void* ref ){
    return [(NSString*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

-(void)setTextColor:(UIColor*)color {
	[self setTextColor:color range:NSMakeRange(0,[self.text length])];
}

-(void)setTextColor:(UIColor*)color range:(NSRange)range {
	[_attributeString removeAttribute:(NSString*)kCTForegroundColorAttributeName range:range];
	[_attributeString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color.CGColor range:range];
}

- (void)drawTextInRect:(CGRect)rect{
    if (_attributeString == nil) {
        [super drawTextInRect:rect];
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    CGContextConcatCTM(ctx, CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.0f, -1.0f));
    
    if (self.shadowColor) {
        CGContextSetShadowWithColor(ctx, self.shadowOffset, 0.0, self.shadowColor.CGColor);
    }
    
    if (_textFrame == NULL) {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributeString);
        _drawingRect = self.bounds;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, _drawingRect);
        _textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
        
        CGFloat width = self.bounds.size.width;
        CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,
                                                                            CFRangeMake(0, _attributeString.length),
                                                                            NULL,
                                                                            CGSizeMake(width, MAXFLOAT),
                                                                            NULL);
        _fixedHeight = suggestedSize.height;
        
        if ([_images count]) {
            [self attachImagesWithFrame:_textFrame];
        }
        
        CGPathRelease(path);
        CFRelease(framesetter);
    }
    
    CTFrameDraw(_textFrame, ctx);
    
    CGContextRestoreGState(ctx);
    
    
    CGContextSaveGState(ctx);
    CGContextConcatCTM(ctx, CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f));
    
    int index = 0;
    for (NSArray* imageData in _imageInfoArr)
    {
        if (index >= [_imageNames count]) {
            continue;
        }
        UIImage *img = [UIImage imageNamed:[_matchDict objectForKey:[_imageNames objectAtIndex:index]]];
        CGRect imgBounds = CGRectFromString([imageData objectAtIndex:0]);
        CGContextClearRect(ctx, imgBounds);
        CGContextDrawImage(ctx, imgBounds, img.CGImage);
        index ++;
    }
    
    CGContextRestoreGState(ctx);
}

-(void)attachImagesWithFrame:(CTFrameRef)f{
    NSArray *lines = (NSArray *)CTFrameGetLines(f);
    
    CGPoint origins[[lines count]];
    CTFrameGetLineOrigins(f, CFRangeMake(0, 0), origins);
    
    int imgIndex = 0;
    NSDictionary* nextImage = [_images objectAtIndex:imgIndex];
    int imgLocation = [[nextImage objectForKey:@"location"] intValue];
    
    NSUInteger lineIndex = 0;
    for (id lineObj in lines) {
        CTLineRef line = (__bridge CTLineRef)lineObj;
        
        for (id runObj in (NSArray *)CTLineGetGlyphRuns(line)) {
            CTRunRef run = (__bridge CTRunRef)runObj;
            CFRange runRange = CTRunGetStringRange(run);
            
            if ( runRange.location <= imgLocation && runRange.location+runRange.length > imgLocation ) {
	            CGRect runBounds;
	            CGFloat ascent;
	            CGFloat descent;
	            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
	            runBounds.size.height = ascent + descent;
                
	            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
	            runBounds.origin.x = origins[lineIndex].x + xOffset;
	            runBounds.origin.y = origins[lineIndex].y;
	            runBounds.origin.y -= descent;
                
                [_imageInfoArr addObject:
                 [NSArray arrayWithObjects:NSStringFromCGRect(runBounds), nil]];
                
                imgIndex++;
                if (imgIndex < [_images count]) {
                    nextImage = [_images objectAtIndex: imgIndex];
                    imgLocation = [[nextImage objectForKey: @"location"] intValue];
                }
            }
        }
        lineIndex++;
    }
}

- (CGFloat)fitHeight{
    return _fixedHeight;
}

+ (NSDictionary*)matchDictWithArray:(NSArray*)array{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    for (NSDictionary *d in array) {
        NSString *name = [d objectForKey:@"name"];
        NSString *img = [d objectForKey:@"img"];
        [mDic setObject:img forKey:name];
    }
    return (NSDictionary*)mDic;
}

+ (CGFloat)fitHeightWithString:(NSString*)string
                          font:(UIFont*)font
                         width:(CGFloat)width
                    matchArray:(NSArray*)array{
    return 300;
}

- (void)dealloc{
    if (_textFrame != NULL) {
        CFRelease(_textFrame);
        _textFrame = NULL;
    }
}

@end
