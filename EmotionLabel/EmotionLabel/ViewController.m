//
//  ViewController.m
//  EmotionLabel
//
//  Created by croath on 11/6/13.
//  Copyright (c) 2013 Croath. All rights reserved.
//

#import "ViewController.h"
#import "EmotionLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    EmotionLabel *label = [[EmotionLabel alloc] init];
    [label setMatchNames:@[@"a", @"b", @"asd"]];
    [label setFrame:CGRectMake(50, 50, 200, 500)];
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [label setNumberOfLines:0];
    [label setText:@"Octokit.net is used [a]in GitHub for Windows and provides an async-based API using HttpClient. Octokit.net req[b]uires .NET 4.5 or later.\
     The \"Octokit\" package is available through NuGet. For Reactive Extensions (Rx) fans, we also have an IObservable-based \"O[cde]ctokit.Reactive\" companion package.\
     We can't wait to see what y[asdf[asd]f]ou'll build with it."];
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
