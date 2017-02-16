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

@interface MainWindowController ()

@property (weak) IBOutlet NSImageView *backgroundImageView;
@property (weak) IBOutlet NSSlider *progressSlider;

@property (strong) AVAudioPlayer* player;
@property (strong) NSMutableArray *musicArray;

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
    
    //init Array
    self.musicArray = [[NSMutableArray alloc] init];
    
    //初始音量
    [self.player setVolume: 0.5];
    
    //选择表格中第一行
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    

}


//上一首
- (IBAction)previousAction:(id)sender {

}

//下一首
- (IBAction)nextAction:(id)sender {
    
}

//播放
- (IBAction)playAction:(id)sender {
    if (self.tableView.selectedRow != -1) {
        //初始化
        NSDictionary *musicDic = self.musicArray[self.tableView.selectedRow];
        NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:musicDic[@"url"]]];
        self.player = [[AVAudioPlayer alloc] initWithData:musicData error:nil ];
        [self.player play];
    }else{
        NSLog(@"列表中没有歌曲！");
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
    if ( [openDlg runModal] == NSOKButton )
    {
        urlArray = [openDlg URLs];
    }
    
    //分析
    for (NSURL *url in urlArray) {
        
        //        NSLog( @"%@", url);
        NSDictionary *ID3Dic = [MusicTools readMusicInfoForFile:url];
        
        
        NSString *filename;
        //URL编码的文件名
        filename = [[[url absoluteString] lastPathComponent] stringByDeletingPathExtension];
        //URL解码
        filename = [filename stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *name = filename;
        NSString *time = ID3Dic[@"approximate duration in seconds"];
        
        NSDictionary *dic = @{@"name":name,@"time":time,@"url":[url absoluteString]};
        
        NSLog(@"%@",dic);
        
        [self.musicArray addObject:dic];
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

    NSDictionary *musicDic = self.musicArray[row];

    if( [tableColumn.identifier isEqualToString:@"number"] ){
        cellView.textField.stringValue = [NSString stringWithFormat:@"%ld",row];
    }else if ([tableColumn.identifier isEqualToString:@"name"]){
        cellView.textField.stringValue = musicDic[@"name"];
    }else if ([tableColumn.identifier isEqualToString:@"time"]){
        cellView.textField.stringValue = [NSString stringWithFormat:@"%d:%.2d",[musicDic[@"time"] intValue] / 60,[musicDic[@"time"] intValue] % 60];
    }
    
    return cellView;
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.musicArray count];
}


@end
