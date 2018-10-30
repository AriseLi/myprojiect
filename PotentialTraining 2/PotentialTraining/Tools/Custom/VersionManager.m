//
//  VersionManager.m
//  naoPlus
//
//  Created by admin on 15/11/7.
//  Copyright admin All rights reserved.
//

#import "VersionManager.h"

static VersionManager *shareManager = nil;

@implementation VersionManager
+ (id) shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[VersionManager alloc] init];
        
    });
    
    return shareManager;
}
@end
