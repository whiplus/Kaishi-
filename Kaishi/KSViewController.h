//
//  KSViewController.h
//  Kaishi
//
//  Created by Whiplus on 2013-06-12.
//  Copyright (c) 2013 Whiplus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KSTimer.h" 

@class KSTimer;
@interface KSViewController : UIViewController
{
    KSTimer *newTimer;
    UIButton *btnfont;
    int blinkCount;
}

- (void)initInterface;

- (void)writeStringToFile:(NSString*)aString;
- (NSString*)readStringFromFile;

- (void)refreshTimeLabel:(id)timer;
- (void)refreshTimerWithMode:(id)currentMode;
- (void)refreshTask:(id)timer;
- (void)blinkTimeLabel;
- (void)reverseBlink;


@end
