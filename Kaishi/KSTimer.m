//
//  KSTimer.m
//  Kaishi
//
//  Created by Whiplus on 2013-06-12.
//  Copyright (c) 2013 Whiplus. All rights reserved.
//

#import "KSTimer.h"
#import "KSViewController.h"

#define STATU_COUNT 7

@implementation KSTimer
@synthesize timeRemain, lastTaskSum, finishedTask, blink;

- (void)initModeList
{
    modeList = [[NSMutableArray alloc] init];
    
    int modeIDList [STATU_COUNT] = {0, 1, 2, 3, 4, 5, 6};
    //NSArray *modeIDList = [NSArray arrayWithObjects:@0, @1, @2, @3, @4, @5, @6, nil];
    NSArray *buttonLabelList = [NSArray arrayWithObjects:@"ready", @"start", @"cancel", @"stop", @"ready", @"ready", @"ready", nil];
    NSArray *modelabelList = [NSArray arrayWithObjects:@"Reset", @"Ready", @"Work", @"Finished", @"Leisure", @"Refreshed", @"Long Leisure", nil];
    int lastingTimeList[STATU_COUNT] = {-1, 10, 25, 10, 5, 10, 25};
    //for test only
    //int lastingTimeList[STATU_COUNT] = {-1, 90, 2, 90, 1, 90, 25};
    int buttonJumpList[STATU_COUNT] = {1, 2, 1, 4, 1, 1, 1};
    int timeJumpList[STATU_COUNT] = {-1, 0, 3, 0, 5, 0, 5};
    NSArray *timeLabelList = [NSArray arrayWithObjects:@"--", @"25", @"25", @"00", @"05", @"00", @"25", nil];
    BOOL refreshTimeList[STATU_COUNT] = {false, false, true, false, true, false, true};
    
    for (int i = 0; i <= 6; i++) {
        KSMode *newMode = [[KSMode alloc] initWithModeID:modeIDList[i] modeLabel:[modelabelList objectAtIndex:i] buttonLabel:[buttonLabelList objectAtIndex:i] lastingTime:lastingTimeList[i] buttonJump:buttonJumpList[i] timeJump:timeJumpList[i] timeLabel:[timeLabelList objectAtIndex:i] hint:[modelabelList objectAtIndex:i] refreshTime:refreshTimeList[i]];
        [modeList addObject:newMode];
        NSLog(@"%d %@ %@", [newMode modeID], [newMode buttonLabel], [newMode hint]);
    }
    
}

- (id)initWithViewController:(id)vController
{
    self = [super init];
    
    if (self)
    {
        [self initModeList];
        
        mode = [modeList objectAtIndex:0];
        
        finishedTask = 0;
        lastTaskSum = 0;
        view = vController;
        [view refreshTimerWithMode:mode];
        
        NSLog(@"Timer initialized");
        newLabel = [[KSTimeLabel alloc] initWithMode:mode Timer:self];
        if ([mode lastingTime] > 0)
            [newLabel updateTime];
    }
    
    return self;
}

- (void)switchMode:(int)source
{
    [newLabel setActive:false];
    newLabel = nil;
    
    if ([mode modeID] == 3)
    {
        finishedTask++;
        [view refreshTask:self];
    }
    
    if ([mode modeID] == 0)
    {
        lastTaskSum = finishedTask;
        finishedTask = 0;
        [view refreshTask:self];
    }
    
    if (source == 1)
    {
        mode = [modeList objectAtIndex:[mode buttonJump]];
        if ([mode modeID] == 4 && finishedTask%4 == 0)
            mode = [modeList objectAtIndex:6];
    }
    else
        mode = [modeList objectAtIndex:[mode timeJump]];
    
    [view refreshTimerWithMode:mode];

    newLabel = [[KSTimeLabel alloc] initWithMode:mode Timer:self];
    if ([mode lastingTime] > 0)
        [newLabel updateTime];
    
}

- (void)refreshTimeLabel:(id)label
{
    if (label)
    {
        timeRemain = [label timeRemaining];
        blink = [label blink];
        [view refreshTimeLabel:self];
    }
}

@end
