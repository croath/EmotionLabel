//
//  EmotionDemoCell.h
//  EmotionLabel
//
//  Created by croath on 11/7/13.
//  Copyright (c) 2013 Croath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionDemoCell : UITableViewCell

- (void)configureWithText:(NSString*)text;

+ (CGFloat)cellHeightWithString:(NSString*)string
                           font:(UIFont*)font
                          width:(CGFloat)width
                     matchArray:(NSArray*)array;

@end
