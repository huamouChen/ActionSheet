//
//  ECActionSheet.h
//  Demo
//
//  Created by MAC-220221 on 2022/2/23.
//

#import <UIKit/UIKit.h>
@class ECActionSheet;

@protocol ECActionSheetDelegate <NSObject>
@optional
- (void)actionSheet:(ECActionSheet *_Nullable)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


#pragma mark - Config
NS_ASSUME_NONNULL_BEGIN
@interface ECAlertConfig : NSObject
/// 选项标题颜色
@property (nonatomic, strong) UIColor *item_titleColor;
/// 选项字体
@property (nonatomic, strong) UIFont *item_font;
/// 容器 左右边距 72.5
@property (nonatomic, assign) CGFloat content_margin_horizontal;
/// 选项 左右边距 25
@property (nonatomic, assign) CGFloat item_margin_horizontal;
/// 选项 上下边距 13
@property (nonatomic, assign) CGFloat item_margin_vertical;
/// 默认行高 47
@property (nonatomic, assign) CGFloat rowHeight;
@end
NS_ASSUME_NONNULL_END



#pragma mark - Alert
typedef void(^clickedButtonAtindexBlock)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN
@interface ECActionSheet : UIView
/// 点击背景消失 默认 YES
@property (nonatomic, assign) BOOL clickBackgroundClose;
/// 点击事件
@property (nonatomic, copy) clickedButtonAtindexBlock clickedButtonAtIndex;
/// 点击回调
@property (nonatomic, weak) id<ECActionSheetDelegate> delegate;

/// 显示
- (void)showInView:(UIView *)view;

- (instancetype)initWithDelegate:(id<ECActionSheetDelegate>)delegate buttonTitles:(NSArray *)titles;
- (instancetype)initWithDelegate:(id<ECActionSheetDelegate>)delegate buttonTitles:(NSArray *)titles buttonImages:(NSArray *)images;


@end
NS_ASSUME_NONNULL_END
