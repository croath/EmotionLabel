//
//  EmotionDemoCell.m
//  EmotionLabel
//
//  Created by croath on 11/7/13.
//  Copyright (c) 2013 Croath. All rights reserved.
//

#import "EmotionDemoCell.h"
#import "EmotionLabel.h"
@interface EmotionDemoCell(){
    EmotionLabel *_label;
}
@end

@implementation EmotionDemoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _label = [[EmotionLabel alloc] init];
        [_label setFont:[UIFont systemFontOfSize:20.f]];
        NSArray *arr = [[NSArray alloc] initWithContentsOfFile:
                        [[NSBundle mainBundle] pathForResource:@"MyEmoji"
                                                        ofType:@"plist"]];
        [_label setMatchArray:arr];
        [_label setFrame:CGRectMake(10, 10, 300, 500)];
        [_label setLineBreakMode:NSLineBreakByCharWrapping];
        [_label setNumberOfLines:0];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureWithText:(NSString*)text{
    [_label setText:text];
}

+ (CGFloat)cellHeightWithString:(NSString*)string
                           font:(UIFont*)font
                          width:(CGFloat)width
                     matchArray:(NSArray*)array{
    return [EmotionLabel fitHeightWithString:string
                                        font:font
                                       width:width
                                  matchArray:array];
}

@end
