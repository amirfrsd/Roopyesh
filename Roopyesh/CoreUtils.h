//
//  CoreUtils.h
//  Roopyesh
//
//  Created by Amir on 8/22/17.
//  Copyright © 2017 Emersad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CoreUtils : NSObject
+ (NSMutableArray *)parseServerResponse:(id)anyObject;
+ (void)showProgressHUD;
+ (void)dismissProgressHUD;
@end
