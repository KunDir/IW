#ifndef IW_COMMON_N
#define IW_COMMON_N
/** 帐号相关*/
#define IWAppKey @"32195145"
#define IWAppSecret @"86f7e97a8b49374de7b0aed1c12f325e"
#define IWRedirectURI @"http://www.csdn.net"

// 判断是否为IOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 自定义Log
#ifdef DEBUG
#define IWLog(...) NSLog(__VA_ARGS__)
#else
#define IWLog(...)
#endif

/** 昵称的字体 */
#define IWStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define IWRetweetStatusNameFont IWStatusNameFont

/** 时间的字体 */
#define IWStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define IWStatusSourceFont IWStatusTimeFont

/** 正文的字体 */
#define IWStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define IWRetweetStatusContentFont IWStatusContentFont

/** 表格的边框宽度 */
#define IWStatusTableBorder 5

/** cell的边框宽度 */
#define IWStatusCellBorder 10

/** 微博cell内部相册*/
#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10

#define IWNotificationCenter [NSNotificationCenter defaultCenter] 


#endif /*IW_COMMON_N*/