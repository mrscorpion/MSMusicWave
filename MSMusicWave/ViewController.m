//
//  ViewController.m
//  MSMusicWave
//
//  Created by mrscorpion on 14/06/13.
//  Copyright © 2014年 mrscorpion. All rights reserved.
//

#import "ViewController.h"
#import "MSMusicWave.h"

#import "XYZViewController.h"

@interface ViewController ()
@property (nonatomic, strong) MSMusicWave *redView;
@property (nonatomic, strong) MSMusicWave *orangeView;

@property (nonatomic, strong) UIButton *flowButton;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
    
    [self.redView startAnimation];
    [self.orangeView startAnimation];
    
    self.flowButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    [self.view addSubview:self.flowButton];
    [self.flowButton setTitle:@"haha" forState:UIControlStateNormal];
    [self.flowButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.flowButton addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tapButton
{
    [self presentViewController:[[XYZViewController alloc] init] animated:YES completion:nil];
}
- (void)configureUI
{
    self.redView = [[MSMusicWave alloc] initWithFrame:CGRectMake(10, 60, 100, 100)];
    [self.view addSubview:self.redView];
    self.redView.pillarColor = [UIColor redColor];
    self.redView.pillarWidth = 2;
    
    self.orangeView = [[MSMusicWave alloc] initWithFrame:CGRectMake(17, 60, 100, 100)];
    [self.view addSubview:self.orangeView];
    self.orangeView.pillarColor = [UIColor orangeColor];
    self.orangeView.pillarWidth = 4;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.redView stopAnimation];
    [self.orangeView stopAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
