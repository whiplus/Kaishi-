//
//  KSMode.h
//  Kaishi
//
//  Created by Whiplus on 2013-06-12.
//  Copyright (c) 2013 Whiplus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSMode : NSObject
{
    int modeID;
    NSString *modeLabel;
    NSString *buttonLabel;
    int lastingTime;
    int buttonJump;
    int timeJump;
    NSString *timeLabel;
    NSString *hint;
    BOOL refreshTime;
}

@property (nonatomic) int modeID;
@property (nonatomic) NSString *modeLabel;
@property (nonatomic) NSString *buttonLabel;
@property (nonatomic) int lastingTime;
@property (nonatomic) int buttonJump;
@property (nonatomic) int timeJump;
@property (nonatomic) NSString *timeLabel;
@property (nonatomic) NSString *hint;
@property (nonatomic) BOOL refreshTime;

- (id)initWithModeID:(int)mid
           modeLabel:(NSString *)mLabel
         buttonLabel:(NSString *)bLabel
         lastingTime:(int)lTime
          buttonJump:(int)bJump
            timeJump:(int)tJump
           timeLabel:(NSString *)tLabel
                hint:(NSString *)ht
         refreshTime:(BOOL)rTime;

@end
