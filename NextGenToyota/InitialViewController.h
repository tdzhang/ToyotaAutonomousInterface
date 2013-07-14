//
//  ViewController.h
//  NextGenToyota
//
//  Created by Michael Chun on 1/29/13.
//  Copyright (c) 2013 Chime Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "NetworkCommunicator.h"
#import "VoiceRecognizer.h"
#import <OpenEars/OpenEarsEventsObserver.h>

@interface InitialViewController : UITableViewController <OpenEarsEventsObserverDelegate>
{
    NetworkCommunicator *nc;
    VoiceRecognizer *vr;
    OpenEarsEventsObserver *openEarsEventsObserver;
};
@property (weak, nonatomic) IBOutlet UILabel *onButton;
@property (weak, nonatomic) IBOutlet UILabel *offButton;
@property (weak, nonatomic) IBOutlet UILabel *LogView;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@end
