//
//  KSTimeLabel.m
//  Kaishi
//
//  Created by Whiplus on 2013-06-12.
//  Copyright (c) 2013 Whiplus. All rights reserved.
//

#import "KSTimeLabel.h"


#define TEST false

@implementation KSTimeLabel
@synthesize timeRemaining, active, blink;

- (id)initWithMode:(KSMode *)currentMode
             Timer:(KSTimer *)t;
    
{
    self = [super init];
    
    if (self)
    {		
        
        timer = t;
        mode = currentMode;
        
        active = true;
        blink = false;
        timeTotal = [mode lastingTime];
        timeStart = [NSDate timeIntervalSinceReferenceDate];
        timeRemaining = timeTotal;
        
        NSLog(@"Time label initialized");
        
        //if (timeTotal > 0)
        //[self updateTime];
    }
    
    return self;
}

- (void)updateTime
{
    
    
    NSTimeInterval timeCurrent = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = timeCurrent - timeStart;
    
    //int hours = (int)(elapsed / 3600.0);
    //elapsed -= hours * 3600;
    int mins = (int)(elapsed / 60.0);
    
    //for test, use secs
    elapsed -= mins * 60;
    int secs = (int)elapsed;
    
    //for release, use mins
    if (TEST)
        timeRemaining = timeTotal - secs;
    else
        timeRemaining = timeTotal - mins;
    
    if (!active)
        return;
    else if ([mode refreshTime])
    {
        NSLog(@"Time refreshed");
        [timer refreshTimeLabel:self];
    }
    if (timeRemaining <= 0)
        {
            [timer switchMode:2];
            NSLog(@"Switch by time");
            return;
        }
    if ((!blink) && ([mode modeID] == 2) && (timeRemaining <= 3 ||  timeRemaining >= 24))
        blink = true;
    else blink = false;
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1];
}

@end
