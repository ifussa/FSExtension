//
// Created by Yimi on 2018/6/1.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface FSNetworkingManager : NSObject
+ (AFHTTPSessionManager *)sharedManager;
- (void)aFNetworkStatus;
@end