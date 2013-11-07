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
        [_label setTextColor:[UIColor darkGrayColor]];
        [_label setShadowColor:[UIColor lightGrayColor]];
        [_label setShadowOffset:CGSizeMake(0, 1)];
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

+ (CGFloat)cellHeightWithString:(NSString*)string{
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:
                      [[NSBundle mainBundle] pathForResource:@"MyEmoji"
                                                      ofType:@"plist"]];
    return [EmotionLabel fitHeightWithString:string
                                        font:[UIFont systemFontOfSize:20.f]
                                       size:CGSizeMake(300.f, MAXFLOAT)
                                  matchArray:array
                               textAlignment:0
                               lineBreakMode:1].height + 20;
}

@end
