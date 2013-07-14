//
//  VoiceRecognizer.h
//  NextGenToyota
//
//  Created by Michael Chun on 2/13/13.
//  Copyright (c) 2013 Chime Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenEars/LanguageModelGenerator.h>
#import <OpenEars/PocketsphinxController.h>

@interface VoiceRecognizer : NSObject
{
    LanguageModelGenerator *lmGenerator;
    PocketsphinxController *pocketsphinxController;
}

- (void)listen;
- (void)suspendRecognition;
- (void)resumeRecognition;

@end
