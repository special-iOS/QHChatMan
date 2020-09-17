//
//  QHChatLiveCloudTFHppleUtil.m
//  QHChatDemo
//
//  Created by Anakin chen on 2020/1/13.
//  Copyright © 2020 Chen Network Technology. All rights reserved.
//

#import "QHChatLiveCloudTFHppleUtil.h"

#import "QHChatBaseUtil.h"
#import "TFHpple/TFHpple.h"
#import "QHHtmlUtil.h"
#import "QHGifTextAttachment.h"

@implementation UIColor (QHPlusPlus)

+ (UIColor *)qh_colorWithHexString:(NSString *)hexString
{
    return [UIColor qh_colorWithHexString:hexString alpha:1.];
}

+ (UIColor *)qh_colorWithHexString:(NSString *)hexString alpha:(float)opacity
{
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    if ([[hexString lowercaseString] hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString length] != 6) {
        return nil;
    }
    
    NSScanner *scanner = [[NSScanner alloc] initWithString:hexString];
    unsigned hexValue = 0;
    if ([scanner scanHexInt:&hexValue] && [scanner isAtEnd]) {
        int r = ((hexValue & 0xFF0000) >> 16);
        int g = ((hexValue & 0x00FF00) >>  8);
        int b = ( hexValue & 0x0000FF)       ;
        return [self colorWithRed:((float)r / 255)
                            green:((float)g / 255)
                             blue:((float)b / 255)
                            alpha:opacity];
    }
    
    return nil;
}

@end

@implementation QHChatLiveCloudTFHppleUtil

+ (NSMutableAttributedString *)toChat:(NSDictionary *)data {
    NSDictionary *body = data[@"body"];
    NSString *n = body[@"nickname"];
    NSString *c = body[@"content"];
    CGFloat w = 20;
    NSString *contentString = [NSString stringWithFormat:@"<font color='#999999'>%@：</font><font color='#151515'>%@ </font><font t='gif' src='http://www.png' w='%f'/><font color='#151515'> 哈喽</font>", n, c, w];
    NSMutableAttributedString *chatData = [NSMutableAttributedString new];
    [self anaylzeHtml:&chatData content:contentString];
    
    return chatData;
}

+ (NSMutableAttributedString *)toGift:(NSDictionary *)data {
    NSDictionary *body = data[@"body"];
    NSString *n = body[@"nickname"];
    NSString *c = body[@"giftName"];
    CGFloat w = 20;
    NSString *contentString = [NSString stringWithFormat:@"<font color='#999999'>%@ 送 </font><font color='#F5A623'>%@</font><font t='img' src='http://www.png' w='%f'/>", n, c, w];
    NSMutableAttributedString *chatData = [NSMutableAttributedString new];
    [self anaylzeHtml:&chatData content:contentString];
    
    NSInteger giftCount = [body[@"giftCount"] integerValue];
    if (giftCount > 1) {
        NSString *giftCountString = [NSString stringWithFormat:@"<font color='#F5A623'> x%li</font>", (long)giftCount];
        [self anaylzeHtml:&chatData content:giftCountString];
    }
    
    return chatData;
}

+ (NSMutableAttributedString *)toEnter:(NSDictionary *)data {
    NSDictionary *body = data[@"body"];
    NSString *n = body[@"nickname"];
    NSString *contentString = [NSString stringWithFormat:@"欢迎 <font color='#999999'>%@</font> 光临直播间", n];
    NSMutableAttributedString *chatData = [NSMutableAttributedString new];
    [self anaylzeHtml:&chatData content:contentString];
    
    return chatData;
}


#pragma mark - Util

+ (void)anaylzeHtml:(NSMutableAttributedString **)chatData content:(NSString *)contentString {
    NSData *data = [contentString dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements = [doc searchWithXPathQuery:@"//font"];
    for (TFHppleElement *element in elements) {
        NSString *type = element.attributes[@"t"];
        if (type != nil && [type isEqualToString:@"img"]) {
            NSString *url = element.attributes[@"src"];
            if (url != nil) {
                UIImage *i = [QHHtmlUtil download:url];
                if (i != nil) {
                    CGFloat w = [element.attributes[@"w"] floatValue];
                    [*chatData appendAttributedString:[QHChatBaseUtil toImage:i size:CGSizeMake(w, w) offBottom:-4]];
                }
            }
        }
        else if (type != nil && [type isEqualToString:@"gif"]) {
            CGFloat w = [element.attributes[@"w"] floatValue];
            QHGifTextAttachment *attachment = [QHGifTextAttachment new];
            attachment.gifName = @"[vip_来一首]";
            attachment.gifWidth = w;
            attachment.bounds = CGRectMake(0, 0, w, w);
            NSAttributedString *a = [NSAttributedString attributedStringWithAttachment:attachment];
            [*chatData appendAttributedString:a];
        }
        else {
            NSString *color = element.attributes[@"color"];
            if (color == nil) {
                color = @"#FFFFFF";
            }
            NSAttributedString *a = [QHChatBaseUtil toContent:element.text color:[UIColor qh_colorWithHexString:color]];
            if (a != nil) {
                [*chatData appendAttributedString:a];
            }
        }
    }
}

@end
