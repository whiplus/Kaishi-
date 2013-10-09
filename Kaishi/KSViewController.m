//
//  KSViewController.m
//  Kaishi
//
//  Created by Whiplus on 2013-06-12.
//  Copyright (c) 2013 Whiplus. All rights reserved.
//

#import "KSViewController.h"
#import "KSMode.h"
#import "KSTimeLabel.h"

#import <AudioToolbox/AudioToolbox.h>
#import "QuartzCore/CAAnimation.h"
#import <UIKit/UIKit.h>

#define TEST false

@interface KSViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskSum;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (weak, nonatomic) IBOutlet UIView *modeBar;

- (IBAction)buttonPressed:(id)sender;

@end

@implementation KSViewController



- (void)initInterface
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    self.timeLabel.font = [UIFont fontWithName:@"Miso-Bold" size:165];
    self.taskSum.font = [UIFont fontWithName:@"Miso-Bold" size:105];
    self.buttonLabel.font = [UIFont fontWithName:@"Miso-Bold" size:35];
    
}

- (void)writeStringToFile:(NSString*)aString
{
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"myTextFile.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // The main act.
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];

}

- (NSString*)readStringFromFile {
    
    // Build the path...
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"myTextFile.txt";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    // The main act...
    // return [[[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath encoding:NSUTF8StringEncoding]] autorelease];
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initInterface];
    
    newTimer = [[KSTimer alloc] initWithViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)refreshTimeLabel:(id)timer
{
    NSLog(@"Time=%d", [timer timeRemain]);
    
    if ([timer timeRemain] >= 10)
        self.timeLabel.text = [NSString stringWithFormat:@"%d", [timer timeRemain]];
    else
        self.timeLabel.text = [NSString stringWithFormat:@"0%d", [timer timeRemain]];
    if ([timer blink] && blinkCount <= 0)
    {
        if (TEST)
            blinkCount = 2;
        else
            blinkCount = 59;
        [self reverseBlink];
    }
    else if (![timer blink])
        blinkCount = 0;
}

- (void)refreshTimerWithMode:(id)currentMode
{
    NSLog(@"Mode=%d",[currentMode modeID]);
    
    NSLog(@"Time=%@", [currentMode timeLabel]);
    
    NSLog(@"Button=%@", [currentMode buttonLabel]);
    
    self.timeLabel.text = [currentMode timeLabel];
    self.buttonLabel.text = [currentMode buttonLabel];
    //[[self myButton] setTitle:[currentMode buttonLabel] forState:UIControlStateNormal];
    
    if ([currentMode modeID] == 3 || [currentMode modeID] == 5) {
        for (int i = 0; i < 3; i++)
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    // if mode == 0, enjoy grey one
    if ([currentMode modeID] == 0)
    {
        UIColor *greyColor = [UIColor colorWithRed:0.300 green:0.300 blue:0.300 alpha:1.000];
        [self.taskSum setTextColor:greyColor];
        
        self.taskSum.text = [self readStringFromFile];
        //test only
        //self.taskSum.text = @"..............";
    }
    
    if ([currentMode modeID] == 1)
    {
        UIColor *whiteColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000];
        [self.taskSum setTextColor:whiteColor];
    }
    
    
    //statusBar
    int red, green, blue;
    if ([currentMode modeID] == 2){
        red = 239; green = 123; blue = 48;
    }
    else if ([currentMode modeID] == 4 || [currentMode modeID] == 6){
        red = 0; green = 217; blue = 217;
    }
    else{
        red = 0; green = 0; blue = 0;
    }
    
    UIColor *myColor = [UIColor colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha: 1];
    self.modeBar.backgroundColor = myColor;
    
    // show the bar
    blinkCount = 1;
    [self blinkTimeLabel];
    if ([currentMode modeID] == 3 || [currentMode modeID] == 5)
        blinkCount = 0;
}

- (void)refreshTask:(id)timer
{
    NSLog(@"Finished=%d", [timer finishedTask]);
    
    NSString *taskStr = [NSString stringWithFormat:@""];
    
    for (int i = 0; i < [timer finishedTask]; i++)
        taskStr = [taskStr stringByAppendingFormat:@"."];
    
    //save the string to file
    [self writeStringToFile:taskStr];
    self.taskSum.text = taskStr;
    
}

- (void)blinkTimeLabel
{
    if (blinkCount > 0)
    {
        NSLog(@"Blink Label");

        self.modeBar.alpha=0.0;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.0f];
        [self.modeBar setAlpha:1];
        [UIView commitAnimations];
    
        blinkCount--;
    
        [self performSelector:@selector(blinkTimeLabel) withObject:self afterDelay:1];
    }
    
}

- (void)reverseBlink
{
    self.modeBar.alpha=1.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    [self.modeBar setAlpha:0];
    [UIView commitAnimations];
    
    self.modeBar.alpha=0.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    [self.modeBar setAlpha:1];
    [UIView commitAnimations];
    
    blinkCount--;
    if (blinkCount > 0)
        [self performSelector:@selector(reverseBlink) withObject:self afterDelay:1];
}

- (IBAction)buttonPressed:(id)sender
{
    NSLog(@"Switch by button");
    [newTimer switchMode:1];
    
    //[sender setTitle:[currentMode buttonLabel] forState:UIControlStateNormal];
}

@end
