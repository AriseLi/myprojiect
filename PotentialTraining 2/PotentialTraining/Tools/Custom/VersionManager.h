//
//  VersionManager.h
//  naoPlus
//
//  Created by admin on 15/11/7.
//  Copyright admin All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionManager : NSObject

@property (nonatomic, copy)NSString *currentVersion;

@property (nonatomic, copy)NSString *activeUrl;

@property (nonatomic, copy)NSString *agreementUrl;


+ (id) shareManager;


@end



