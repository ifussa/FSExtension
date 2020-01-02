//
//  FSDefine.h
//  FSExtensionDemo
//
//  Created by Fussa on 2020/1/2.
//  Copyright © 2020 Fussa. All rights reserved.
//

#ifndef FSDefine_h
#define FSDefine_h

/// 清除PerformSelector方法警告
#define MTFYSuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

#endif /* FSDefine_h */
