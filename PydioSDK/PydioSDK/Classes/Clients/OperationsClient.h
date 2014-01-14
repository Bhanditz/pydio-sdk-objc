//
//  OperationsClient.h
//  PydioSDK
//
//  Created by ME on 14/01/14.
//  Copyright (c) 2014 MINI. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AFHTTPRequestOperationManager;

@interface OperationsClient : NSObject
@property (nonatomic,strong) AFHTTPRequestOperationManager *operationManager;
@property (readonly,nonatomic,assign) BOOL progress;

-(BOOL)listFilesWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;
@end
