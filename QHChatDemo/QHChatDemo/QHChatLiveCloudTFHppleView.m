//
//  QHChatLiveCloudTFHppleView.m
//  QHChatDemo
//
//  Created by Anakin chen on 2020/1/13.
//  Copyright © 2020 Chen Network Technology. All rights reserved.
//

#import "QHChatLiveCloudTFHppleView.h"

#import "QHChatLiveCloudTFHppleUtil.h"
#import "QHChatLiveCloudHtmlContentViewCell.h"
#import "QHChatLiveCloudDateViewCell.h"

NSString *const kChatOpKey2 = @"op";
NSString *const kChatOpValueChat2 = @"chat";
NSString *const kChatOpValueGift2 = @"gift";
NSString *const kChatOpValueEnter2 = @"enter";

@interface QHChatLiveCloudTFHppleView () <QHChatBaseViewCellDelegate>

@end

@implementation QHChatLiveCloudTFHppleView

- (void)qhChatAddCell2TableView:(UITableView *)tableView {
    [tableView registerClass:[QHChatLiveCloudHtmlContentViewCell class] forCellReuseIdentifier:@"QHChatLiveCloudHtmlContentViewCell"];
    [tableView registerClass:[QHChatLiveCloudDateViewCell class] forCellReuseIdentifier:@"QHChatLiveCloudDateViewCell"];
}

- (UITableViewCell *)qhChatChatView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *chatCell = nil;
    QHChatBaseModel *model = [self.buffer getChatData:indexPath.row];
    NSDictionary *data = model.originChatDataDic;
    NSString *op = data[kChatOpKey];
    if ([op isEqualToString:kChatOpValueDate] == YES) {
        QHChatLiveCloudDateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QHChatLiveCloudDateViewCell" forIndexPath:indexPath];
        cell.contentL.text = data[kQHCHAT_LC_SHOWDATE_KEY];
        chatCell = cell;
    }
    else {
        if (model.chatAttributedText != nil) {
            QHChatLiveCloudHtmlContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QHChatLiveCloudHtmlContentViewCell"];
            cell.contentT.attributedText = model.chatAttributedText;
            [cell.contentT start];
            cell.delegate = self;
            chatCell = cell;
        }
    }
    return chatCell;
}

- (NSMutableAttributedString *)qhChatAnalyseContent:(NSDictionary *)data {
    NSString *op = data[kChatOpKey2];
    NSMutableAttributedString *content = nil;
    if ([op isEqualToString:kChatOpValueChat2] == YES) {
        content = [QHChatLiveCloudTFHppleUtil toChat:data];
    }
    else if ([op isEqualToString:kChatOpValueGift2] == YES) {
        content = [QHChatLiveCloudTFHppleUtil toGift:data];
    }
    else if ([op isEqualToString:kChatOpValueEnter2] == YES) {
        content = [QHChatLiveCloudTFHppleUtil toEnter:data];
    }
    return content;
}

@end
