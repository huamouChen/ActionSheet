//
//  ECActionSheet.m
//  Demo
//
//  Created by MAC-220221 on 2022/2/23.
//

#import "ECActionSheet.h"
#import "ECPositionButton.h"

#define kLineColor  [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]


#pragma mark - Config
@implementation ECAlertConfig
- (instancetype)init {
    if (self = [super init]) {
        self.item_titleColor = [UIColor colorWithRed:44/255.0 green:44/255.0 blue:44/255.0 alpha:1.0];
        self.item_font = [UIFont fontWithName:@"PingFang SC" size: 15];
        self.content_margin_horizontal = 72.5;
        self.item_margin_horizontal = 25;
        self.item_margin_vertical = 13;
        self.rowHeight = 47;
    }
    return self;
}
@end

#pragma mark - Alert
@interface ECActionSheet ()

/// 配置
@property (nonatomic, strong) ECAlertConfig *config;
/// 容器试图
@property (nonatomic, strong) UIView *contentView;
/// 标题数组
@property (nonatomic, strong) NSArray<NSString *> *buttonTitles;
/// 图片数组
@property (nonatomic, strong) NSArray<NSString *> *buttonImages;

@end

@implementation ECActionSheet

#pragma mark  show dismiss
- (void)showInView:(UIView *)view {
    self.frame = [UIScreen mainScreen].bounds;
    if (!view) {
        view = [UIApplication sharedApplication].delegate.window;
    }
    [view addSubview:self];
    self.alpha = 0;
    self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 1.2, 1.2);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1.0;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)dismissAlert {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 0.1, 0.1);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)tapBackgroundView {
    if (_clickBackgroundClose) {
        [self dismissAlert];
    }
}

#pragma mark  init
- (instancetype)initWithDelegate:(id<ECActionSheetDelegate>)delegate buttonTitles:(NSArray *)titles {
    return [self initWithDelegate:delegate buttonTitles:titles buttonImages:@[]];
}
- (instancetype)initWithDelegate:(id<ECActionSheetDelegate>)delegate buttonTitles:(NSArray *)titles buttonImages:(NSArray *)images {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.delegate = delegate;
        [self initilal];
        self.buttonTitles = titles;
        self.buttonImages = images;
        [self createItemView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initilal];
    }
    return self;
}
- (void)initilal {
    // 默认点击背景关闭弹框
    self.clickBackgroundClose = YES;
    // 默认配置
    self.config = [ECAlertConfig new];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.contentView];
    
}
/// 创建选项
- (void)createItemView {
    CGFloat content_w = [UIScreen mainScreen].bounds.size.width - _config.content_margin_horizontal * 2;
    CGFloat content_h = 0;
    CGFloat item_w = [UIScreen mainScreen].bounds.size.width - (_config.content_margin_horizontal + _config.item_margin_horizontal) * 2;
    for (int i = 0; i < _buttonTitles.count; i++) {
        ECPositionButton *btn = [[ECPositionButton alloc] initWithFrame:CGRectZero];
        btn.tag = 1001 + i;
        [btn addTarget:self action:@selector(clickItemButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = _config.item_font;
        btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [btn setTitleColor:_config.item_titleColor forState:UIControlStateNormal];
        [btn setTitle:_buttonTitles[i] forState:UIControlStateNormal];
        if (i < _buttonImages.count && _buttonImages[i] && _buttonImages[i].length > 0) {
            [btn setImage:[UIImage imageNamed:_buttonImages[i]] forState:UIControlStateNormal];
        }
        btn.btnStyle = ECPositionButtonStyleLeft;
        btn.betweenMargin = 5;
        // 最大宽度
        btn.titleLabel.preferredMaxLayoutWidth = item_w;
        CGFloat item_h = btn.titleLabel.intrinsicContentSize.height;
        item_h = (item_h + _config.item_margin_vertical * 2)  <= _config.rowHeight ? _config.rowHeight : (item_h + _config.item_margin_vertical * 2);
        btn.frame = CGRectMake(_config.item_margin_horizontal, content_h, item_w, item_h);
        content_h += item_h;
        [self.contentView addSubview:btn];
        
        // 分割线
        if (i < _buttonTitles.count - 1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, content_h, content_w, 0.5)];
            line.backgroundColor = kLineColor;
            [self.contentView addSubview:line];
            content_h += 0.5;
        }
    }
    
    CGFloat content_y = ([UIScreen mainScreen].bounds.size.height - content_h) * 0.5;
    self.contentView.frame = CGRectMake(_config.content_margin_horizontal, content_y, content_w, content_h);
}

#pragma mark 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_clickBackgroundClose) {
        [self dismissAlert];
    }
}
/// 点击选项按钮
- (void)clickItemButton:(UIButton *)sender {
    [self dismissAlert];
    NSInteger index = sender.tag - 1001;
    // block
    if (self.clickedButtonAtIndex) {
        self.clickedButtonAtIndex(index);
    }
    // 代理
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:index];
    }
}

#pragma mark  懒加载
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(_config.content_margin_horizontal, 0, [UIScreen mainScreen].bounds.size.width - _config.content_margin_horizontal * 2, 0)];
        _contentView.backgroundColor = UIColor.whiteColor;
        _contentView.layer.cornerRadius = 8;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}


@end



