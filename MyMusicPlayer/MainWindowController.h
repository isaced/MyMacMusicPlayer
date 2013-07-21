//
//  MainWindowController.h
//  MyMusicPlayer
//
//  Created by isaced on 13-7-21.
//  Copyright (c) 2013年 isaced. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainWindowController : NSWindowController<NSTableViewDataSource>


//---
- (IBAction)addMusicToListAction:(id)sender;
- (IBAction)previousAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)playAction:(id)sender;
- (IBAction)soundVolumeSliderChangeAction:(id)sender;

@property (weak) IBOutlet NSTableView *tableView;


@end
