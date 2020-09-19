//
//  QHHtmlUtil.m
//  QHChatDemo
//
//  Created by Anakin chen on 2020/9/17.
//  Copyright © 2020 Chen Network Technology. All rights reserved.
//

#import "QHHtmlUtil.h"

@implementation QHGifImageView

@end

@implementation QHHtmlUtil

+ (UIImage *)download:(NSString *)url {
    NSString *p = [[NSBundle mainBundle] pathForResource:@"vip_来一首" ofType:@"png"];
    UIImage *i = [UIImage imageWithContentsOfFile:p];
    return i;
}

+ (QHGifImageView *)gif:(NSString *)url {
    NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource:@"[vip_来一首]" withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:gifImageUrl];
    NSTimeInterval duration = [self durationForGifData:data];
    //获取Gif图的原数据
//    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifImageUrl, NULL);
    CGImageSourceRef gifSource = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    size_t gifcount = CGImageSourceGetCount(gifSource);

    NSMutableArray *images = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < gifcount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [images addObject:image];
        CGImageRelease(imageRef);
    }
    
    QHGifImageView *iv = [QHGifImageView new];
    iv.animationImages = images;
    iv.animationDuration = duration;
    
    return iv;
}

+ (NSTimeInterval)durationForGifData:(NSData *)data {
    char graphicControlExtensionStartBytes[] = {0x21,0xF9,0x04};
    double duration = 0;
    NSRange dataSearchLeftRange = NSMakeRange(0, data.length);
    while (YES) {
        NSRange frameDescriptorRange = [data rangeOfData:[NSData dataWithBytes:graphicControlExtensionStartBytes length:3]
                                                 options:NSDataSearchBackwards
                                                   range:dataSearchLeftRange];
        if (frameDescriptorRange.location != NSNotFound) {
            NSData *durationData = [data subdataWithRange:NSMakeRange(frameDescriptorRange.location + 4, 2)];
            unsigned char buffer[2];
            [durationData getBytes:buffer length:2];
            double delay = (buffer[0] | buffer[1] << 8);
            duration += delay;
            dataSearchLeftRange = NSMakeRange(0, frameDescriptorRange.location);
        }
        else {
            break;
        }
    }
    return duration/100;
}

@end
