//
//  ViewController.m
//  EmotionLabel
//
//  Created by croath on 11/6/13.
//  Copyright (c) 2013 Croath. All rights reserved.
//

#import "ViewController.h"
#import "EmotionLabel.h"
#import "EmotionDemoCell.h"
#include <time.h>

@interface ViewController (){
    NSArray *textArray;
    UITableView *_tableView;
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
                  @"[a][a][a][a][a][a][a][a][asdfddd][a][a][a][a][a][a][a][a][a][a][a][a][a][a][a]",
                  @"",
                  @"no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.\
                  no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.\
                  no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.no emotion.",
                  @"1",
                  @"[a]😄[b]😍[a]emotions here😌[asd]what's up?"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [EmotionDemoCell cellHeightWithString:[textArray objectAtIndex:indexPath.row % [textArray count]]];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EmotionDemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseId"];
    if (cell == nil) {
        cell = [[EmotionDemoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"reuseId"];
    }
    
    [cell configureWithText:[textArray objectAtIndex:indexPath.row % [textArray count]]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
