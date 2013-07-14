//
//  VoiceRecognizer.m
//  NextGenToyota
//
//  Created by Michael Chun on 2/13/13.
//  Copyright (c) 2013 Chime Lab. All rights reserved.
//

#import "VoiceRecognizer.h"

@implementation VoiceRecognizer

NSDictionary *languageGeneratorResults = nil;
NSString *lmPath = nil;
NSString *dicPath = nil;


- (id)init
{
    if ( self = [super init] )
    {
        lmGenerator = [[LanguageModelGenerator alloc] init];
        
        NSArray *words = [NSArray arrayWithObjects:@"AUTODRIVE", @"MANUALDRIVE", @"SOME", @"OTHER", nil];
        NSString *name = @"AutomationLanguageModel";
        NSError *err = [lmGenerator generateLanguageModelFromArray:words withFilesNamed:name];
        
        if([err code] == noErr) {
            
            languageGeneratorResults = [err userInfo];
            
            lmPath = [languageGeneratorResults objectForKey:@"LMPath"];
            dicPath = [languageGeneratorResults objectForKey:@"DictionaryPath"];
       		pocketsphinxController = [[PocketsphinxController alloc] init];
            pocketsphinxController.returnNullHypotheses = YES;
            
            
        } else {
            NSLog(@"Error: %@",[err localizedDescription]);
        }
        return self;
    }
    return nil;
}

- (void)listen
{
    [pocketsphinxController startListeningWithLanguageModelAtPath:lmPath dictionaryAtPath:dicPath languageModelIsJSGF:NO];
}

- (void)suspendRecognition
{
    [pocketsphinxController suspendRecognition];
}

- (void)resumeRecognition
{
    [pocketsphinxController resumeRecognition];
}

@end
