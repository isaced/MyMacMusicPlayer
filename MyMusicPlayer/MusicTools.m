//
//  MusicTools.m
//  MyMusicPlayer
//
//  Created by isaced on 13-7-21.
//  Copyright (c) 2013年 isaced. All rights reserved.
//

#import "MusicTools.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation MusicTools

+(NSDictionary *)readMusicInfoForFile:(NSURL *)fileName{

    NSDictionary *resultDic;
    
    //----
    
//    NSURL *audioURL = [NSURL fileURLWithPath:fileName];
    AudioFileID audioFile;
    OSStatus theErr = noErr;
    theErr = AudioFileOpenURL((__bridge CFURLRef)fileName,
                              kAudioFileReadPermission,
                              0,
                              &audioFile);
    assert (theErr == noErr);
    UInt32 dictionarySize = 0;
    theErr = AudioFileGetPropertyInfo (audioFile,
                                       kAudioFilePropertyInfoDictionary,
                                       &dictionarySize,
                                       0);
    assert (theErr == noErr);
    CFDictionaryRef dictionary;
    theErr = AudioFileGetProperty (audioFile,
                                   kAudioFilePropertyInfoDictionary,
                                   &dictionarySize,
                                   &dictionary);
    assert (theErr == noErr);
    resultDic = (__bridge NSDictionary *)(dictionary);  //Convert
    CFRelease (dictionary);
    theErr = AudioFileClose (audioFile);
    assert (theErr == noErr);
    
//    NSLog (@"dictionary: %@", resultDic);

    return resultDic;
}

@end
