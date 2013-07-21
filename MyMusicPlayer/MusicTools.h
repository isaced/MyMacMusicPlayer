//
//  MusicTools.h
//  MyMusicPlayer
//
//  Created by isaced on 13-7-21.
//  Copyright (c) 2013年 isaced. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicTools : NSObject

//读取文件信息（ID3）
+ (NSDictionary *)readMusicInfoForFile:(NSURL *)fileName;

@end
