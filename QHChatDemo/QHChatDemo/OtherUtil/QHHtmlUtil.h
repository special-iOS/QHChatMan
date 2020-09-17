//
//  QHHtmlUtil.h
//  QHChatDemo
//
//  Created by Anakin chen on 2020/9/17.
//  Copyright © 2020 Chen Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QHHtmlUtil : NSObject

+ (UIImage *)download:(NSString *)url;
+ (UIImageView *)gif:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
