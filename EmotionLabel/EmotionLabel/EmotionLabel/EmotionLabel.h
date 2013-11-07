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
+ (CGFloat)fitHeightWithString:(NSString*)string
                          font:(UIFont*)font
                         width:(CGFloat)width
                    matchArray:(NSArray*)array
                 textAlignment:(uint8_t)textAlignment
                 lineBreakMode:(uint8_t)lineBreakMode;
@end
