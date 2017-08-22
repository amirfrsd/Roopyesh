//
//  CoreNetworking.h
//  Roopyesh
//
//  Created by Amir on 8/22/17.
//  Copyright © 2017 Emersad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreNetworking : NSObject
typedef void (^ResponseBlock)(BOOL success, id response);
+ (void)getShows:(ResponseBlock)block;
@end
