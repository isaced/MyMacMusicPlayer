//
//  Music.h
//  MyMusicPlayer
//
//  Created by isaced on 2017/3/12.
//  Copyright © 2017年 isaced. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) NSURL *fileURL;

- (instancetype)initWithFile:(NSURL *)url;

- (NSData *)readData;

@end
