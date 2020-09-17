//
//  QHHtmlUtil.m
//  QHChatDemo
//
//  Created by Anakin chen on 2020/9/17.
//  Copyright © 2020 Chen Network Technology. All rights reserved.
//

#import "QHHtmlUtil.h"

@implementation QHHtmlUtil

+ (UIImage *)download:(NSString *)url {
    NSString *p = [[NSBundle mainBundle] pathForResource:@"vip_来一首" ofType:@"png"];
    UIImage *i = [UIImage imageWithContentsOfFile:p];
    return i;
}

+ (UIImageView *)gif:(NSString *)url {
    NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource:@"[vip_来一首]" withExtension:@"gif"];

    //获取Gif图的原数据
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifImageUrl, NULL);

    //获取Gif图有多少帧
    size_t gifcount = CGImageSourceGetCount(gifSource);

    NSMutableArray *images = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < gifcount; i++) {
            
        //由数据源gifSource生成一张CGImageRef类型的图片
        
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [images addObject:image];
        CGImageRelease(imageRef);
    }
    
    UIImageView *iv = [UIImageView new];
    iv.animationImages = images;
    iv.animationDuration = 0.2;
    [iv startAnimating];
    
    return iv;
}

@end
