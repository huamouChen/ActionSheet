//
//  ECButton.h
//  Demo
//
//  Created by MAC-220221 on 2022/2/22.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ECPositionButtonStyle) {
    EPositionCButtonStyleDefault = 0, // 默认，什么也不动
    ECPositionButtonStyleTop,         // image在上，label在下
    ECPositionButtonStyleLeft,        // image在左，label在右
    ECPositionButtonStyleBottom,      // image在下，label在上
    ECPositionButtonStyleRight        // image在右，label在左
};

NS_ASSUME_NONNULL_BEGIN

@interface ECPositionButton : UIButton

/// 按钮 文字、图片 位置样式
@property (nonatomic, assign) ECPositionButtonStyle btnStyle;

/// 文字 图片的间距，默认 4
@property (nonatomic, assign) CGFloat betweenMargin;

/// 自定义位置，比如DSButtonStyleTop的时候，就是图片的Y值, DSButtonStyleLeft的时候就是图片的X值，DSButtonStyleBottom的时候就是文字的Y值，DSButtonStyleRight的时候就是文字的X值
@property (nonatomic, assign) CGFloat margin_start;

@end

NS_ASSUME_NONNULL_END
