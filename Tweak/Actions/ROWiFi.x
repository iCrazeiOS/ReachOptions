// ReachOptions
// Copyright (c) ajaidan0 2020

#import "ROWiFi.h"

@implementation ROWiFi

+(void)exec {
    BOOL wiFiEnabled = [[%c(SBWiFiManager) sharedInstance] wiFiEnabled];
    [[%c(SBWiFiManager) sharedInstance] setWiFiEnabled:!wiFiEnabled];
}

@end