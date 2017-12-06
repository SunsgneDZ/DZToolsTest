//
//  TestView.m
//  DZToolsTest
//
//  Created by dzk on 2017/12/4.
//  Copyright © 2017年 dzk. All rights reserved.
//

#import "TestView.h"

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        btn.backgroundColor = [UIColor blueColor];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnAc) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}
- (void)btnAc{
    
    if (self.cancel) {
        self.cancel();
    }
}

@end
