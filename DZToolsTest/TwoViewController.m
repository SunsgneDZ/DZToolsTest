//
//  TwoViewController.m
//  DZToolsTest
//
//  Created by dzk on 2017/12/4.
//  Copyright © 2017年 dzk. All rights reserved.
//

#import "TwoViewController.h"
#import "TestView.h"
@interface TwoViewController ()

@property (nonatomic, strong) TestView *v;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.v = [[TestView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    self.v.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.v];
    self.v.cancel = ^{
        NSLog(@"2222");
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
