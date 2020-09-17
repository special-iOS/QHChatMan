//
//  QHChatLiveCloudView.h
//  QHChatDemo
//
//  Created by Anakin chen on 2018/12/28.
//  Copyright © 2018 Chen Network Technology. All rights reserved.
//

#import "QHChatBaseView.h"

#define kQHCHAT_LC_SHOWDATE_KEY @"lcstk"

extern NSString *const kChatOpKey;
extern NSString *const kChatOpValueChat;
extern NSString *const kChatOpValueGift;
extern NSString *const kChatOpValueDate;
extern NSString *const kChatOpValueEnter;

NS_ASSUME_NONNULL_BEGIN

@interface QHChatLiveCloudView : QHChatBaseView

- (void)lcInsertChatData:(NSArray<NSDictionary *> *)data;

@end

NS_ASSUME_NONNULL_END
