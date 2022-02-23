//
//  ECButton.m
//  Demo
//
//  Created by MAC-220221 on 2022/2/22.
//

#import "ECPositionButton.h"

@implementation ECPositionButton

- (instancetype)init {
    if (self = [super init]) {
        [self initialConfig];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialConfig];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self =  [super initWithCoder:coder]) {
        [self initialConfig];
    }
    return self;
}
- (void)initialConfig {
    _margin_start = -1;
    _betweenMargin = 4;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat total_w = self.bounds.size.width;
    CGFloat total_h = self.bounds.size.height;
    
    // 得到imageView和titleLabel的宽、高
    CGFloat image_w = self.imageView.frame.size.width;
    CGFloat image_h = self.imageView.frame.size.height;
    
    CGFloat label_w = self.titleLabel.intrinsicContentSize.width;
    CGFloat label_h = self.titleLabel.intrinsicContentSize.height;
    
    switch (_btnStyle) {
        case ECPositionButtonStyleTop:
        {
            CGFloat image_x = (total_w - image_w) * 0.5;
            // 默认居中
            CGFloat image_y = (total_h - image_h - label_h - _betweenMargin) * 0.5;
            // 是否是自定义位置
            if (_margin_start > -1) {
                image_y = _margin_start;
            }
            self.imageView.frame = CGRectMake(image_x, image_y, image_w, image_h);
            
            CGFloat label_x = (total_w - label_w) * 0.5;
            CGFloat label_y = CGRectGetMaxY(self.imageView.frame) + _betweenMargin;
            self.titleLabel.frame = CGRectMake(label_x, label_y, label_w, label_h);
        }
            break;
        case ECPositionButtonStyleLeft:
        {
            // 默认居中
            CGFloat image_x = (total_w - image_w - label_w - _betweenMargin) * 0.5;
            // 是否是自定义位置
            if (_margin_start > -1) {
                image_x = _margin_start;
            }
            CGFloat image_y = self.imageView.frame.origin.y;
            self.imageView.frame = CGRectMake(image_x, image_y, image_w, image_h);
            
            CGFloat label_x = CGRectGetMaxX(self.imageView.frame) + _betweenMargin;
            CGFloat label_y = self.titleLabel.frame.origin.y;
            self.titleLabel.frame = CGRectMake(label_x, label_y, label_w, label_h);
        }
            break;
        case ECPositionButtonStyleBottom:
        {
            // 默认居中
            CGFloat label_x = (total_w - label_w) * 0.5;
            CGFloat label_y = (total_h - image_h - label_h - _betweenMargin) * 0.5;
            // 是否是自定义位置
            if (_margin_start > -1) {
                label_y = _margin_start;
            }
            self.titleLabel.frame = CGRectMake(label_x, label_y, label_w, label_h);
            
            CGFloat image_x = (total_w - image_w) * 0.5;
            CGFloat image_y =  CGRectGetMaxY(self.titleLabel.frame) + _betweenMargin;
            self.imageView.frame = CGRectMake(image_x, image_y, image_w, image_h);
            
        }
            break;
        case ECPositionButtonStyleRight:
        {
            // 默认居中
            CGFloat label_x = (total_w - image_w - label_w - _betweenMargin) * 0.5;
            // 是否是自定义位置
            if (_margin_start > -1) {
                label_x = _margin_start;
            }
            CGFloat label_y = self.titleLabel.frame.origin.y;
            self.titleLabel.frame = CGRectMake(label_x, label_y, label_w, label_h);
            
            CGFloat image_x = CGRectGetMaxX(self.titleLabel.frame) + _betweenMargin;
            CGFloat image_y = self.imageView.frame.origin.y;
            self.imageView.frame = CGRectMake(image_x, image_y, image_w, image_h);
            
        }
            break;
            
        default:
            break;
    }
}


@end
