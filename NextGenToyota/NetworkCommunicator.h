//
//  NetworkCommunicator.h
//  NextGenToyota
//
//  Created by Michael Chun on 1/31/13.
//  Copyright (c) 2013 Chime Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkCommunicator : NSObject <NSStreamDelegate>
{
    NSString *_host;
    int _port;    
}

- (id)initNetworkCommunication:(NSString *)host :(int)port;
- (void) sendMessage:(NSString *) msg;
@end
