//
//  KSMode.m
//  Kaishi
//
//  Created by Whiplus on 2013-06-12.
//  Copyright (c) 2013 Whiplus. All rights reserved.
//

#import "KSMode.h"

@implementation KSMode

@synthesize modeID, modeLabel, buttonJump, lastingTime, timeJump, timeLabel, hint, refreshTime, buttonLabel;

- (id)initWithModeID:(int)mid
           modeLabel:(NSString *)mLabel
         buttonLabel:(NSString *)bLabel
         lastingTime:(int)lTime
          buttonJump:(int)bJump
            timeJump:(int)tJump
           timeLabel:(NSString *)tLabel
                hint:(NSString *)ht
         refreshTime:(BOOL)rTime
{
    self = [super init];
    
    if (self)
    {
        [self setModeID:mid];
        [self setModeLabel:mLabel];
        [self setButtonLabel:bLabel];
        [self setLastingTime:lTime];
        [self setButtonJump:bJump];
        [self setTimeJump:tJump];
        [self setTimeLabel:tLabel];
        [self setHint:ht];
        [self setRefreshTime:rTime];
    }
    
    return self;
}


@end
