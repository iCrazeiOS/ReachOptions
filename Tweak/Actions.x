// ReachOptions
// Copyright (c) ajaidan0

#import "Actions-Structs.h"

@implementation ReachOptions

// Control Center action
+(void)ControlCenter {
    [[%c(SBControlCenterController) sharedInstance] presentAnimated:YES];
}

// Lock action
+(void)Lock {
    [(SpringBoard *)[UIApplication sharedApplication] _simulateLockButtonPress];   
}

// Respring
+(void)Respring {
    NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:@"/usr/bin/killall"];
    [task setArguments:@[@"-9", @"SpringBoard"]];
	[task launch];
}

// Screenshot
+(void)Screenshot {
    [(SpringBoard *)[UIApplication sharedApplication] takeScreenshot];
}

// Spotlight
+(void)Spotlight {
    [(AXSpringBoardServer *)[%c(AXSpringBoardServer) server] revealSpotlight];
}

// UICache
+(void)UICache {
    NSTask *task = [[NSTask alloc] init];
	[task setLaunchPath:@"/usr/bin/uicache"];
    [task setArguments:@[]];
	[task launch];
}

//WiFi
+(void)WiFi {
    BOOL wiFiEnabled = [[%c(SBWiFiManager) sharedInstance] wiFiEnabled];
    [[%c(SBWiFiManager) sharedInstance] setWiFiEnabled:!wiFiEnabled];
}

@end