//
//  KSTimer.h
//  Kaishi
//
//  Created by Whiplus on 2013-06-12.
//  Copyright (c) 2013 Whiplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSViewController.h"
#import "KSMode.h"
#import "KSTimeLabel.h"

@class KSViewController;
@class KSTimeLabel;

@interface KSTimer : NSObject
{
    KSMode *mode;
    int finishedTask, lastTaskSum, timeRemain;
    KSViewController *view;
    NSMutableArray *modeList;
    KSTimeLabel *newLabel;
    BOOL blink;
}

@property (nonatomic) int timeRemain;
@property (nonatomic) int finishedTask;
@property (nonatomic) int lastTaskSum;
@property (nonatomic) BOOL blink;


- (void)initModeList;

- (id)initWithViewController:(id)vController;
- (void)switchMode:(int)source;

- (void)refreshTimeLabel:(id)label;

@end
