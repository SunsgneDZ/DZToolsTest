//
//  DZTools.m
//  DZToolsTest
//
//  Created by dzk on 2017/8/29.
//  Copyright © 2017年 dzk. All rights reserved.
//

#import "DZTools.h"

static CGRect oldframe;

@implementation DZTools


+ (CGFloat)getTextHeight:(NSString *)text Width:(CGFloat)width Font:(UIFont *)font{
    if (text.length != 0) {
        CGSize size = [text boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
        return size.height;
    }
    
    return 0;
}

+ (CGFloat)getTextWidth:(NSString *)text Height:(CGFloat)height Font:(UIFont *)font {
    if (text.length != 0) {
        CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        
        return size.width;
    }
    
    return 0;
}

//放大图片
+(void)showImage:(UIImageView *)avatarImageView{
    
    //获得点击图片
    UIImage *image=avatarImageView.image;
    //获取Windows
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    //创建遮罩视图
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    
    //创建放大展示视图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    
    //创建保存按钮
    UIButton *storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    storeBtn.frame = CGRectMake(kScreenWidth-10-60, 20, 60, 30);
    [storeBtn setTitle:@"保 存" forState:0];
    storeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    storeBtn.layer.borderWidth = 0.5;
    [storeBtn setTitleColor:[UIColor whiteColor] forState:0];
    storeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [storeBtn addTarget:self action:@selector(storeToPhotoAlbumWith:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:storeBtn];
    
    //点击隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    //动画展示
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

//隐藏
+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

//保存到相册
+(void)storeToPhotoAlbumWith:(UIButton *)btn{
    
    UIImage *image=nil;
    
    for (UIImageView *imageView in btn.superview.subviews) {
        
        if ([imageView isKindOfClass:[UIImageView class]]) {
            
            image = imageView.image;
        }
    }
    
    
    UIImageWriteToSavedPhotosAlbum(image,self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
//方法回调
+(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (!error) {
        
    }else{
    
    }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    //    NSLog(@"%@",jsonString);
    
    
    if (jsonString == nil ) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    //    NSLog(@"%@",dic);
    if(err) {
        
        NSLog(@"%@--json解析失败：%@",jsonString,err);
        
        
        return @{};
        
    }
    
    return dic;
    
}


+ (NSArray *)arrayWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                    
                                                   options:NSJSONReadingMutableContainers
                    
                                                     error:&err];
    //    NSLog(@"%@",dic);
    if(err) {
        
        NSLog(@"%@--json解析失败：%@",jsonString,err);
        
        
        return @[];
        
    }
    
    return arr;
}



/**
 数组转json字符串
 
 @param array 传入的数组
 @return 返回json字符串
 */
+ (NSString *)jsonStringWithArray:(NSArray *)array{
    if (!array) {
        return nil;
    }
    
    NSError *err;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&err];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (err) {
        NSLog(@"转换失败%@",err);
    }
    
    return jsonString;
    
}

//判断身份证
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}


@end
