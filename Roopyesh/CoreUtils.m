//
//  CoreUtils.m
//  Roopyesh
//
//  Created by Amir on 8/22/17.
//  Copyright © 2017 Emersad. All rights reserved.
//

#import "CoreUtils.h"
#import <SVProgressHUD.h>

@implementation CoreUtils
+ (NSMutableArray *)parseServerResponse:(id)anyObject {
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    for (NSDictionary *show in anyObject) {
        //let str = summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<[^>]+>" options:NSRegularExpressionCaseInsensitive error:nil];
        NSString *summaryString = [regex stringByReplacingMatchesInString:[show valueForKey:@"summary"] options:0 range:NSMakeRange(0, [[show valueForKey:@"summary"] length]) withTemplate:@""];
        NSDictionary *subDataSource = @{@"id":[show valueForKey:@"id"], @"name":[show valueForKey:@"name"], @"language":[show valueForKey:@"language"],@"premiered":[show valueForKey:@"premiered"], @"rating":[[show valueForKey:@"rating"] valueForKey:@"average"], @"summary":summaryString, @"image":[[show valueForKey:@"image"] valueForKey:@"medium"]};
        [dataSource addObject:subDataSource];
    }
    return dataSource;
}
+ (void)showProgressHUD {
    [SVProgressHUD show];
}
+ (void)dismissProgressHUD {
    [SVProgressHUD dismiss];
}
@end
