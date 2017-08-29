//
//  DZTools.h
//  DZToolsTest
//
//  Created by dzk on 2017/8/29.
//  Copyright © 2017年 dzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DZTools : NSObject

//计算文本高度
+ (CGFloat)getTextHeight:(NSString *)text Width:(CGFloat)width Font:(UIFont *)font;

//计算文本宽度
+ (CGFloat)getTextWidth:(NSString *)text Height:(CGFloat)height Font:(UIFont *)font;

//图片放大查看
+ (void)showImage:(UIImageView *)selectImageView;

/**
 json字符串转成字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 json字符串转成数组
 */
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;


/**
 数组转成json字符串
 */
+ (NSString *)jsonStringWithArray:(NSArray *)array;

/**
 身份证是否正确
 
 */
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;

@end
