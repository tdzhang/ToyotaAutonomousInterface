//
//  ViewController.m
//  NextGenToyota
//
//  Created by Michael Chun on 1/29/13.
//  Copyright (c) 2013 Chime Lab. All rights reserved.
//

#import "InitialViewController.h"

@implementation InitialViewController
@synthesize onButton;
@synthesize offButton;
@synthesize audioPlayer;

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    nc = [[NetworkCommunicator alloc] initNetworkCommunication:@"101.101.101.2" :7990];
    vr = [[VoiceRecognizer alloc] init];
    openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
    [openEarsEventsObserver setDelegate:self];
    [vr listen];
}

- (void)viewWillAppear:(BOOL)animated
{
    UITableView *mainTableView = (UITableView *)self.view;
    [mainTableView setBackgroundView:nil];
    [mainTableView setBackgroundView:[[UIView alloc] init]];
    
    NSIndexPath *idx = [NSIndexPath indexPathForRow:1 inSection:0];
    [mainTableView selectRowAtIndexPath:idx animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
        return YES;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Clear information text when screen is touched.
    [self.LogView setText:@""
     ];
    
    if (indexPath.row == 0) [self processCommand:1];
    else  [self processCommand:2];
    
    return indexPath;
}

- (void)processCommand:(int) command{
    [self.audioPlayer stop];
    
    if (command == 1) {
        [nc sendMessage:@"1"];
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Version1ON_clipped" ofType:@"m4a"];
        self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:nil];
    }
    else if (command == 2) {
        [nc sendMessage:@"0"];
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Version1OFF_clipped" ofType:@"m4a"];
        self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundPath] error:nil];
    }
    
    NSTimeInterval duration = self.audioPlayer.duration;
    [vr suspendRecognition];
    [NSTimer scheduledTimerWithTimeInterval:duration/2 target:vr selector:@selector(resumeRecognition) userInfo:nil repeats:NO];
    [self.audioPlayer play];

}

- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    NSString *msg = [NSString stringWithFormat:@"Recognized: %@  Score: %@", hypothesis, recognitionScore];
	NSLog(@"%@",msg);
    
    [self.LogView setText:msg];
    
    UITableView *mainTableView = (UITableView *)self.view;
    
    if ([hypothesis isEqualToString:@"AUTODRIVE"] && ([recognitionScore intValue] > -2500) ){
        NSIndexPath *idx = [NSIndexPath indexPathForRow:0 inSection:0];
        [self processCommand:1];
        [mainTableView selectRowAtIndexPath:idx animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if ([hypothesis isEqualToString:@"MANUALDRIVE"] && ([recognitionScore intValue] > -2500)) {
        NSIndexPath *idx = [NSIndexPath indexPathForRow:1 inSection:0];
        [self processCommand:2];
        [mainTableView selectRowAtIndexPath:idx animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}




- (void)viewDidUnload {
    [self setLogView:nil];
    [super viewDidUnload];
}
@end
