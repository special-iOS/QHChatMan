//
//  QHGifTextView.m
//  QHChatDemo
//
//  Created by Anakin chen on 2020/9/17.
//  Copyright © 2020 Chen Network Technology. All rights reserved.
//

#import "QHGifTextView.h"

#import "QHHtmlUtil.h"
#import "QHGifTextAttachment.h"

@interface QHGifTextView ()

@property (nonatomic, strong) NSAttributedString *attrGif;

@end

@implementation QHGifTextView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self p_setup];
    }
    return self;
}

- (void)p_setup {
    self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    self.editable = NO;
//    self.selectable = YES;
    self.scrollEnabled = NO;
}

- (void)setGifAttributedText:(NSAttributedString *)attributedText {
    
//    if (self.attrGif != nil && self.attrGif == attributedText) {
//        return;
//    }
    
//    self.clipsToBounds = NO;
//    self.backgroundColor = [UIColor clearColor];
    
    __block BOOL bFind = NO;
    __block NSMutableArray *insert = [NSMutableArray new];
//    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[QHGifTextAttachment class]]) {
            bFind = YES;
            QHGifTextAttachment *gifTextAttachment = value;
            self.selectedRange = range;
            CGRect rect = [self firstRectForRange:self.selectedTextRange];
//            CGRect rect = [self frameOfTextRange:range];
            NSLog(@"chen>>%@,%@,%@", attributedText.string, NSStringFromCGRect(rect), NSStringFromRange(self.selectedRange));
            if (rect.size.width > 0) {
                if (rect.origin.x + gifTextAttachment.gifWidth > self.frame.size.width) {
                    rect = (CGRect){0, rect.origin.y + gifTextAttachment.gifWidth, 0, 0};
                }
                UIImageView *iv = [QHHtmlUtil gif:@""];
                iv.frame = (CGRect){rect.origin.x, rect.origin.y, gifTextAttachment.gifWidth, gifTextAttachment.gifWidth};
                iv.backgroundColor = [UIColor greenColor];
                [self addSubview:iv];
    
                [insert addObject:iv];
            }
        }
    }];
    self.selectedRange = NSMakeRange(0, 0);
    
    if (bFind == NO) {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [subView removeFromSuperview];
            }
        }
    }

    if (insert.count > 0) {
        self.attrGif = attributedText;
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [subView removeFromSuperview];
            }
        }
        for (UIImageView *iv in insert) {
            [self addSubview:iv];
        }
    }
}

@end
