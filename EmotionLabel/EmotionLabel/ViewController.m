//
//  ViewController.m
//  EmotionLabel
//
//  Created by croath on 11/6/13.
//  Copyright (c) 2013 Croath. All rights reserved.
//

#import "ViewController.h"
#import "EmotionLabel.h"
#include <time.h>

@interface ViewController (){
    EmotionLabel *label;
    NSArray *textArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    textArray = @[@"Octokit.net is used [a]in GitHub for Windows and provides an async-based API using HttpClient. Octokit.net req[b]uires .NET 4.5 or later.",
                  @"The \"Octokit\" package is available through NuGet. For Reactive Extensions (Rx) fans, we also have an IObservable-based \"O[cde]ctokit.Reactive\" companion package.\
                  We can't wait to see what y[asdf[asd]f]ou'll build with it.\
                  Octokit.net is used [a]in GitHub for Windows and provides an async-based API using HttpClient. Octokit.net req[b]uires .NET 4.5 or later.",
                  @"[a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a]",
                  @"[a][a][a][a][a][a][a][a][asdfddd][a][a][a][a][a][a][a][a][a][a][a][a][a]",
                  @"",
                  @"no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.\
                  no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.\
                  no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.",
                  @"1",
                  @"[a]😄[b]😍[a]emotions here😌[asd]what's up?"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(120, 20, 70, 20)];
    [btn setTitle:@"change" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    label = [[EmotionLabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:20.f]];
    [label setMatchNames:@[@"a", @"b", @"asd"]];
    [label setFrame:CGRectMake(50, 50, 200, 500)];
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [label setNumberOfLines:0];
    [label setText:[textArray objectAtIndex:0]];
    [self.view addSubview:label];
}

- (void)change{
    srand((unsigned)time(0));
    [label setText:[textArray objectAtIndex:rand()%8]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
