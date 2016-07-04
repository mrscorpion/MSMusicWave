//
//  XYZViewController.m
//  demo6_PhotoRiver
//
//  Created by BOBO on 15/3/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "XYZViewController.h"
#import "XYZPhoto.h"

//定义图片大小
#define IMAGEWIDTH 120
#define IMAGEHEIGHT 160

@interface XYZViewController ()
@property (nonatomic, strong) NSMutableArray * photos;
@property (nonatomic, strong) NSArray *photoPaths;
@end

@implementation XYZViewController
- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [[NSMutableArray alloc]init];
    }
    return _photos;
}
- (NSArray *)photoPaths
{
    if (!_photoPaths) {
        _photoPaths = @[@"blankpage_NetError", @"blankpage_NoData", @"blankpage_NoMessage", @"load1", @"Unknown"];
    }
    return _photoPaths;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    //获取图片文件路径
//    self.photos = [[NSMutableArray alloc]init];
//    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSLog(@"path =%@", path);
//    
//    //将jpg/JPG格式的图片路径添加到数组中，用于循环显示
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
//    for (NSString *fileName in fileNames ) {
//        if ([fileName hasSuffix:@"jpg"] || [fileName hasSuffix:@"JPG"]) {
//            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
//            [photoPaths addObject:photoPath];
//        }
//    }
    
    
    //添加图片到界面中

    if (self.photoPaths.count > 0) {
        for (int i = 0; i < self.photoPaths.count; i++) {
            //随机设置图片在屏幕上的显示位置
            float X = arc4random()%((int)self.view.bounds.size.width - IMAGEWIDTH);
            float Y = arc4random()%((int)self.view.bounds.size.height - IMAGEHEIGHT);
            float W = IMAGEWIDTH;
            float H = IMAGEHEIGHT;
            
            XYZPhoto *photo = [[XYZPhoto alloc]initWithFrame:CGRectMake(X, Y, W, H)];
//            [photo updateImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
            [photo updateImage:[UIImage imageNamed:self.photoPaths[i]]];
            [self.view addSubview:photo];
            
            float alpha = i*1.0/10 + 0.2;
//            [photo setImageAlphaAndSpeedAndSize:alpha];
            [photo setImageAlpha:alpha speed:0.1 size:1];
            
            [self.photos addObject:photo];
        }
    }

    //增加双击手势，双击改变图片布局
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
}

- (void)doubleTap {
    
    NSLog(@"DoubleTap...........");
    
    //当图片处于绘图状态或者放大显示状态时，手势无效
    for (XYZPhoto *photo in self.photos) {
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateBig) {
            return;
        }
    }
    
    float W = self.view.bounds.size.width / 3;
    float H = self.view.bounds.size.height / 3;
    
    //添加动画
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            XYZPhoto *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == XYZPhotoStateNormal) {
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.alpha = 1;
                photo.frame = CGRectMake(i%3*W, i/3*H, W, H);
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.speed = 0;
                photo.state = XYZPhotoStateTogether;
            } else if (photo.state == XYZPhotoStateTogether) {
                photo.alpha = photo.oldAlpha;
                photo.frame = photo.oldFrame;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.state = XYZPhotoStateNormal;
            }
        }

    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
