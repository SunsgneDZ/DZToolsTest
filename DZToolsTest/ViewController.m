//
//  ViewController.m
//  DZToolsTest
//
//  Created by dzk on 2017/8/29.
//  Copyright © 2017年 dzk. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "TwoViewController.h"
#import "TestView.h"

@interface ViewController ()<UITextFieldDelegate>
{
    UITextField *_inputView;
    UILabel *_showLabel;
    UIImageView *_imageView;
    
}

@property (nonatomic, strong) TestView *v;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//
//    _inputView = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth-20, 30)];
//    _inputView.textColor = [UIColor whiteColor];
//    _inputView.backgroundColor = [UIColor grayColor];
//
//    _inputView.delegate = self;
//    [self.view addSubview:_inputView];
//
//
//    _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, kScreenWidth-20, 30)];
//    _showLabel.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:_showLabel];
//
//
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, kScreenWidth-60, 200)];
//    [self.view addSubview:_imageView];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:@"http://lezhuadmin.icooder.com//upload/admimgs/2017081117352520423_thumb.jpeg"]];
//
//
//    SDImageCache *cache =[SDImageCache sharedImageCache];
//    NSInteger a = [cache getSize];
//
//    NSLog(@"%f",a/1000.f);//kb
//
//
//    NSLog(@"%@",NSHomeDirectory());

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 30)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAc) forControlEvents:UIControlEventTouchUpInside];
    
    self.v = [[TestView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    self.v.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.v];
    self.v.cancel = ^{
        NSLog(@"1111");
    };
    
}
- (void)btnAc{
    TwoViewController *two = [[TwoViewController alloc] init];
    [self.navigationController pushViewController:two animated:YES];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    CGFloat width = [DZTools getTextWidth:textField.text Height:30 Font:textField.font];
    
    _showLabel.text = [NSString stringWithFormat:@"长度等于%f",width];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
