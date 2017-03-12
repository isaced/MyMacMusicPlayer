//
//  MainWindowController.m
//  MyMusicPlayer
//
//  Created by isaced on 13-7-21.
//  Copyright (c) 2013年 isaced. All rights reserved.
//

#import "MainWindowController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MusicTools.h"
#import "Music.h"

@interface MainWindowController () <NSDraggingDestination>

@property (weak) IBOutlet NSImageView *backgroundImageView;
@property (weak) IBOutlet NSSlider *progressSlider;

@property (strong) AVAudioPlayer* player;
@property (strong) NSMutableArray<Music *> *musicList;

@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Title Bar
    self.window.titlebarAppearsTransparent = YES;
    self.window.titleVisibility = NSWindowTitleHidden;
    self.window.styleMask |= NSFullSizeContentViewWindowMask;
    
    // Window Style
    NSColor *windowBackgroundColor = [NSColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0];
    [self.window setBackgroundColor: windowBackgroundColor];
    self.window.movableByWindowBackground = YES;
    
    // Drag and drop
    [self.window registerForDraggedTypes:@[NSFilenamesPboardType]];
    [self.backgroundImageView unregisterDraggedTypes];
    
    //init Array
    self.musicList = [[NSMutableArray alloc] init];
    
    //初始音量
    [self.player setVolume: 0.5];
    
    //选择表格中第一行
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
}

- (Music *)loadMusicWithFileURL:(NSURL *)url {
    [self.player stop];
    
    // 从文件读取音频信息
    Music *music = [[Music alloc] initWithFile:url];
    
    // 将音乐加载到 AVAudioPlayer
    self.player = [[AVAudioPlayer alloc] initWithData:[music readData] error:nil];
    
    return music;
}

//上一首
- (IBAction)previousAction:(id)sender {

}

//下一首
- (IBAction)nextAction:(id)sender {
    
}

// 播放 & 暂停
- (IBAction)playAction:(id)sender {
    if (self.player.playing) {
        [self.player pause];
    }else{
        [self.player play];
    }
}


- (IBAction)addMusicToListAction:(id)sender {
    
    //初始化 NSOpenPanel
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    //只能选择文件
    [openDlg setCanChooseFiles:YES];
    [openDlg setCanChooseDirectories:NO];
    
    //允许多选
    [openDlg setAllowsMultipleSelection:YES];
    
    NSArray *urlArray;
    
    //打开
    if ([openDlg runModal] == NSOKButton) {
        urlArray = [openDlg URLs];
    }
    
    //分析
    for (NSURL *url in urlArray) {
        Music *music = [[Music alloc] initWithFile:url];
        [self.musicList addObject:music];
    }
    
    [self.tableView reloadData];
}

//音量调节 - Slider
- (IBAction)soundVolumeSliderChangeAction:(id)sender {
    NSSlider *slider = (NSSlider *)sender;
    [self.player setVolume:slider.doubleValue];
}
    
//Tableview
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];

    Music *music = self.musicList[row];

    if( [tableColumn.identifier isEqualToString:@"number"] ){
        cellView.textField.stringValue = [NSString stringWithFormat:@"%ld",row];
    }else if ([tableColumn.identifier isEqualToString:@"name"]){
        cellView.textField.stringValue = music.title;
    }else if ([tableColumn.identifier isEqualToString:@"time"]){
        cellView.textField.stringValue = [NSString stringWithFormat:@"%d:%.2d",(int)music.duration / 60, (int)music.duration % 60];
    }
    
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.musicList count];
}


#pragma mark <NSDraggingDestination>

- (BOOL)shouldAllowDrag:(id<NSDraggingInfo>)draggingInfo {
    BOOL canAccept = NO;
    NSPasteboard *pasteBoard = [draggingInfo draggingPasteboard];
    if ([pasteBoard canReadObjectForClasses:@[[NSURL class]] options:nil]) {
        canAccept = YES;
    }
    return canAccept;
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender{
    return NSDragOperationGeneric;
}

-(void)draggingExited:(id<NSDraggingInfo>)sender{

}

-(BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender{
    return [self shouldAllowDrag:sender];
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender{
    NSPasteboard *pasteBoard = [sender draggingPasteboard];
    NSArray *urls = [pasteBoard readObjectsForClasses:@[[NSURL class]] options:nil];
    NSLog(@"Drag and drop : %@",urls);
    
    NSURL *url = [urls firstObject];
    if (url) {
        Music *music = [self loadMusicWithFileURL:url];
        self.TitleTextField.stringValue = [NSString stringWithFormat:@"%@ - %@",music.title,music.artist];
        [self.player play];
    }
    
    return YES;
}

@end
