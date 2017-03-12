//
//  Music.m
//  MyMusicPlayer
//
//  Created by isaced on 2017/3/12.
//  Copyright © 2017年 isaced. All rights reserved.
//

#import "Music.h"
#import "MusicTools.h"

@implementation Music

-(instancetype)initWithFile:(NSURL *)url {
    if (self=[super init]) {
        
        self.fileURL = url;
        
        NSDictionary *ID3Dic = [MusicTools readMusicInfoForFile:url];
        
        self.title = ID3Dic[@"title"];
        self.artist = ID3Dic[@"artist"];
        self.duration = [ID3Dic[@"approximate duration in seconds"] doubleValue];
    }
    return self;
}

- (NSData *)readData {
    return [NSData dataWithContentsOfURL:self.fileURL];
}

@end
