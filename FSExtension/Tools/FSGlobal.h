//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "FSApp.h"

#define FS_RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define FS_RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]


#pragma mark Screen
/// 屏幕高度、宽度
#define FS_kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define FS_kScreenHeight [[UIScreen mainScreen] bounds].size.height

///iphone x适配相关
/// 是否是刘海屏
#define FS_isiPhoneX [FSApp isiPhoneXScreen]

/// iphone x StatusBar+NavigationBar高度
#define FS_kSafeAreaTopHeight (FS_isiPhoneX ? 88 : 64)

/// iphone x 底部圆角区域高度
#define FS_kSafeAreaBottomHeight (FS_isiPhoneX ? 34 : 0)

/// iphone x StatusBar高度
#define FS_kSafeAreaStatusBarHeight (FS_isiPhoneX ? 44 : 20)

/// iphone x TabBar+底部圆角区域高度
#define FS_kSafeAreaTabBarHeight (FS_isiPhoneX ? 83 : 49)

#define FS_adjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#pragma mark - System Version
/// 当前系统版本大于等于某版本
#define FS_IOS_SYSTEM_VERSION_EQUAL_OR_ABOVE(v) (([[[UIDevice currentDevice] systemVersion] floatValue] >= (v))? (YES):(NO))

/// 当前系统版本小于等于某版本
#define FS_IOS_SYSTEM_VERSION_EQUAL_OR_BELOW(v) (([[[UIDevice currentDevice] systemVersion] floatValue] <= (v))? (YES):(NO))

/// 获取应用名
#define FS_APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/// 获取BundleVersion
#define FS_APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/// 获取ShortVersion
#define FS_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#pragma mark - view size, frame
/// 根据字符串、最大尺寸、字体计算字符串最合适尺寸
static inline CGSize FS_CGSizeOfString(NSString * text, CGSize maxSize, UIFont * font) {
    CGSize fitSize;
#ifdef __IPHONE_7_0
    fitSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
#else
    fitSize = [text sizeWithFont:font constrainedToSize:maxSize];
#endif
    return fitSize;
}


/// 读取本地图片
#define FS_LOAD_IMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

/// 定义UIImage对象
#define FS_IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

/// 定义UIImage对象
#define FS_ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

/// key window
#define FS_KEY_WINDOW [UIApplication sharedApplication].keyWindow

