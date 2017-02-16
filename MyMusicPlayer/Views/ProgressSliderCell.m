//
//  ProgressSlider.m
//  MyMusicPlayer
//
//  Created by feeling on 2017/2/16.
//  Copyright © 2017年 isaced. All rights reserved.
//

#import "ProgressSliderCell.h"

@implementation ProgressSliderCell


- (void)drawBarInside:(NSRect)rect flipped:(BOOL)flipped {
    
    //  [super drawBarInside:rect flipped:flipped];
    
    rect.size.height = 5.0;
    
    // Bar radius
    CGFloat barRadius = 2.5;
    
    // Knob position depending on control min/max value and current control value.
    CGFloat value = ([self doubleValue]  - [self minValue]) / ([self maxValue] - [self minValue]);
    
    // Final Left Part Width
    CGFloat finalWidth = value * ([[self controlView] frame].size.width - 8);
    
    // Left Part Rect
    NSRect leftRect = rect;
    leftRect.size.width = finalWidth;
    
    NSLog(@"- Current Rect:%@ \n- Value:%f \n- Final Width:%f", NSStringFromRect(rect), value, finalWidth);
    
    // Draw Left Part
    NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: rect xRadius: barRadius yRadius: barRadius];
    [[NSColor colorWithRed:75/255.0 green:76/255.0 blue:76/255.0 alpha:1.0] setFill];
    [bg fill];
    
    // Draw Right Part
    NSBezierPath* active = [NSBezierPath bezierPathWithRoundedRect: leftRect xRadius: barRadius yRadius: barRadius];
    [[NSColor colorWithRed:60/255.0 green:137/255.0 blue:139/255.0 alpha:1.0] setFill];
    [active fill];
    
    
}
@end
