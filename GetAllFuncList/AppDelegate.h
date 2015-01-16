//
//  AppDelegate.h
//  GetAllFuncList
//
//  Created by 尹现伟 on 15-1-16.
//  Copyright (c) 2015年 DNE Technology Co.,Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (IBAction)openFile:(id)sender;

@property (unsafe_unretained) IBOutlet NSTextView *textVIew;

@end

