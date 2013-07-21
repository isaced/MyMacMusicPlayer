//
//  AppDelegate.m
//  MyMusicPlayer
//
//  Created by isaced on 13-7-21.
//  Copyright (c) 2013年 isaced. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@interface  AppDelegate()

@property (nonatomic,strong) IBOutlet MainWindowController *mainWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindowController"];
    [self setWindow:self.mainWindowController.window];
}

@end
