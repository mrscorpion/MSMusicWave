//
//  MSMusicWave.h
//  MSMusicWave
//
//  Created by mrscorpion on 14/06/13.
//  Copyright © 2014年 mrscorpion. All rights reserved.
//

#import <UIKit/UIKit.h>

/*! 显示音乐播放的动画 */
@interface MSMusicWave : UIControl

/*! 开始动画 */
- (void)startAnimation;

/*! 结束动画 */
- (void) stopAnimation;

/*! 柱子的宽度 */
@property (assign, nonatomic) CGFloat pillarWidth;

/*! 柱子的颜色 */
@property (strong, nonatomic) UIColor * pillarColor;

@end
