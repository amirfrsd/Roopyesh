//
//  CoreNetworking.m
//  Roopyesh
//
//  Created by Amir on 8/22/17.
//  Copyright © 2017 Emersad. All rights reserved.
//

#import "CoreNetworking.h"

@implementation CoreNetworking
+ (void)getShows:(ResponseBlock)block {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:@"http://api.tvmaze.com/shows"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (((NSHTTPURLResponse *)response).statusCode == 200) {
                id jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                block(YES, jsonArray);
            } else {
                block(NO, @{});
            }
        } else {
            block(NO, @{});
            NSLog(@"URLSession Task Failed:%@", [error localizedDescription]);
        }
    }];
    [task resume];
}
@end
