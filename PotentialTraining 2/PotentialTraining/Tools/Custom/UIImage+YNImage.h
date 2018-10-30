//
//  UIImage+YNImage.h
//  YN微博
//
//  Created by 王宇宁 on 15/8/11.
//  Copyright (c) 2015年 王宇宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YNImage)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;

//根据图片名返回一张能够自由拉伸的图片
+ (instancetype)resizedImage: (NSString *)name;

@end
