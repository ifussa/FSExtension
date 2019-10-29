//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FSBase64 : NSObject

NSData * b64_encode( NSData * data );
NSData * b64_decode( NSData * data );
void decodeblock( unsigned char in[4], unsigned char out[3] );

@end