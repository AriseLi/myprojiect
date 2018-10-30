//
//  UIImage+YNImage.m
//  YN微博
//
//  Created by 王宇宁 on 15/8/11.
//  Copyright (c) 2015年 王宇宁. All rights reserved.
//

#import "UIImage+YNImage.h"

@implementation UIImage (YNImage)


//加载最原始图片 不渲染
//加载分类 能够直接食用这个类方法
+(instancetype)imageWithOriginalName:(NSString *)imageName
{
   UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    
   return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5  topCapHeight:image.size.height * 0.5];
}

@end
