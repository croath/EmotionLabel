//
//  EmotionLabel.h
//  EmotionLabel
//
//  Created by croath on 11/6/13.
//  Copyright (c) 2013 Croath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionLabel : UILabel

@property (nonatomic, strong) NSArray *matchArray;

- (CGFloat)fitHeight;
+ (CGSize)fitHeightWithString:(NSString*)string
                         font:(UIFont*)font
                         size:(CGSize)size
                   matchArray:(NSArray*)array
                textAlignment:(uint8_t)textAlignment
                lineBreakMode:(uint8_t)lineBreakMode;
@end
