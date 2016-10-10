//
//  SJPullRefreshImageView.h
//  SJRefresh
//
//  Created by zhoushejun on 16/10/9.
//  Copyright © 2016年 zhoushejun. All rights reserved.
//

/**
 @header    SJPullRefreshImageView.h
 @abstract  画弧度 转圈
 @author    shejun.zhou
 @version   1.0 16/10/10 Creation
 */

#import <UIKit/UIKit.h>

/**
 @class     SJPullRefreshImageView
 @abstract  画弧度
 */
@interface SJPullRefreshImageView : UIImageView

@property (nonatomic, assign) BOOL isAnimation;


/**
 @method    drawStartAngle: endAngle:
 @abstract  画弧度
 @param     startAngle : 开始弧度
 @param     endAngle : 结束弧度
 */
- (void)drawStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;

/** 开始转圈动画 */
- (void)startAnimation;
/** 结束动画 */
- (void)endAnimation;

@end
