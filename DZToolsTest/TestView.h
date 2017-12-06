//
//  TestView.h
//  DZToolsTest
//
//  Created by dzk on 2017/12/4.
//  Copyright © 2017年 dzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestView : UIView

@property (nonatomic, copy) void (^cancel)(void);

@end
