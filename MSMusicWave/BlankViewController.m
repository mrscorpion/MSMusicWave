//
//  BlankViewController.m
//  MSMusicWave
//
//  Created by 清风 on 16/6/30.
//  Copyright © 2016年 mrscorpion. All rights reserved.
//

#import "BlankViewController.h"
#import "UIView+LZLodingOrBlank.h"

@interface BlankViewController ()
{
    LZBlankPageView *_blankView;
}
@end

@implementation BlankViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    [self sendRequest];
    
}
-(void)sendRequest{
    [self.view beginLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        NSDictionary *dic = nil;
        /**
         Type 1
         */
        //   [self showBlankPageWithType:LZBlankPageTypeNoData reloadButtonBlock:nil];
        
        /**
         Type 2
         */
        [self.view configBlankPage:LZBlankPageTypeNetError hasData:(dic)  reloadButtonBlock:^(id sender) {
            [self sendRequest];
        }];
        
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showBlankPageWithType:(LZBlankPageType)type reloadButtonBlock:(void (^)(id))block{
    [self dismissBlankPage];
    _blankView=[[LZBlankPageView alloc] initWithFrame:CGRectZero];
    [_blankView configWithType:LZBlankPageTypeNoData hasData:NO reloadButtonBlock:block];
    [self.view addSubview:_blankView];
    
    [_blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.size.equalTo(self.view);
        
    }];
    self.view.userInteractionEnabled=YES;
}
-(void)dismissBlankPage{
    if (_blankView) {
        [_blankView removeFromSuperview];
        _blankView=nil;
    }
}
@end
