//
//  AppDelegate.h
//  IndianLeaders
//
//  Created by Nilesh on 26/05/16.
//  Copyright © 2016 Nilesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *songName;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

-(void)playSong:(NSString *)song;

@end

