//
//  QHChatLiveCloudHtmlContentViewCell.m
//  QHChatDemo
//
//  Created by Anakin chen on 2020/9/17.
//  Copyright © 2020 Chen Network Technology. All rights reserved.
//

#import "QHChatLiveCloudHtmlContentViewCell.h"

#import "QHViewUtil.h"

@interface QHChatLiveCloudHtmlContentViewCell ()

@property (nonatomic, strong, readwrite) QHGifTextView *contentT;

@end

@implementation QHChatLiveCloudHtmlContentViewCell

- (void)dealloc {
#if DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setup];
    }
    return self;
}

#pragma mark - Private

- (void)p_setup {
    self.backgroundColor = [UIColor clearColor];
    [self p_addContentView];
    [self p_addContentLabel];
    [self addTapGesture];
}

- (void)p_addContentLabel {
    _contentT = [QHGifTextView new];
    [self.contentV addSubview:_contentT];
    [QHViewUtil fullScreen:_contentT edgeInsets:QHCHAT_LC_CONTENT_TEXT_EDGEINSETS];
}

#pragma mark - Action

- (void)tapGestureAction:(id)sender {
    
}

@end
