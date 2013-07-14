//
//  NetworkCommunicator.m
//  NextGenToyota
//
//  Created by Michael Chun on 1/31/13.
//  Copyright (c) 2013 Chime Lab. All rights reserved.
//

#import "NetworkCommunicator.h"

@implementation NetworkCommunicator

- (id)initNetworkCommunication:(NSString *)host :(int)port
{
    if ( self = [super init] ) {
        _host = host;
        _port = port;
        
        return self;
    }
    return nil;
}

- (void) sendMessage:(NSString *) msg
{
    CFWriteStreamRef writeStream;
    CFReadStreamRef readStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)CFBridgingRetain(_host), _port, &readStream, &writeStream);
    NSOutputStream *outputStream = (NSOutputStream *)CFBridgingRelease(writeStream);
    NSInputStream *inputStream = (NSInputStream *)CFBridgingRelease(readStream);;
    
    [outputStream open];
    [inputStream open];
    
    NSData *data = [[NSData alloc] initWithData:[msg dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    [outputStream close];
    [inputStream close];
}


@end
