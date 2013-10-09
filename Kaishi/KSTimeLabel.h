//
//  KSTimeLabel.h
//  Kaishi
//
//  Created by Whiplus on 2013-06-12.
//  Copyright (c) 2013 Whiplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSMode.h"
#import "KSViewController.h"
#import "KSTimer.h"

@class KSViewController;
@class KSTimer;

@interface KSTimeLabel : NSObject
{
    int timeTotal, timeRemaining;
    NSTimeInterval timeStart;
    __weak KSMode *mode;
    //KSViewController *view;
    __weak KSTimer *timer;
    
    BOOL blink;
    BOOL active;
}

@property (nonatomic) int timeRemaining;
@property (nonatomic) BOOL active;
@property (nonatomic) BOOL blink;


- (void)updateTime;

- (id)initWithMode:(KSMode*)currentMode
             Timer:(KSTimer*)t;

@end
