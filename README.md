EmotionLabel
============

emotion label

wanna some emotions in your label? DTCoreText too slow cost too much CPU and mem?

Try it.

![s_1](https://raw.github.com/croath/EmotionLabel/master/doc/s_1.png)
![s_2](https://raw.github.com/croath/EmotionLabel/master/doc/s_2.png)
![s_3](https://raw.github.com/croath/EmotionLabel/master/doc/s_3.png)

##Alloc

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

##MatchArray(Plist

like this : 

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <array>
    	<dict>
    		<key>name</key>
    		<string>a</string>
    		<key>img</key>
    		<string>a</string>
    	</dict>
    	<dict>
    		<key>name</key>
    		<string>b</string>
    		<key>img</key>
    		<string>b</string>
    	</dict>
    	<dict>
    		<key>name</key>
    		<string>asd</string>
    		<key>img</key>
    		<string>asd</string>
    	</dict>
    </array>
    </plist>
	

----

and put the `img` value images into your project.

##Auto Fit Height

here here

    + (CGFloat)fitHeightWithString:(NSString*)string
                              font:(UIFont*)font
                             width:(CGFloat)width
                        matchArray:(NSArray*)array
                     textAlignment:(uint8_t)textAlignment
                     lineBreakMode:(uint8_t)lineBreakMode;