// ReachOptions
// Copyright (c) ajaidan0 2020

#import "ReachOptions.h"

%hook SBReachabilityManager

-(void)_setKeepAliveTimer {
    // This is to disable the timer on reachability. I did this because sometimes the menu would dismiss (much like reachability) without any notice.
    if (isEnabled) {} else {
        %orig;
    }
}

-(void)_activateReachability:(id)arg1 {
    if (isEnabled) {
        // Setup menu
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Pick an action." message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *reach = [UIAlertAction actionWithTitle:@"Return to Reachability" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {return %orig;}]; // Open Reachability
        UIAlertAction *one = [UIAlertAction actionWithTitle:@"Take a Screenshot" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[%c(ROScreenshot) exec];}]; // Take screenshot
        UIAlertAction *two = [UIAlertAction actionWithTitle:@"Open Control Center" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[%c(ROControlCenter) exec];}]; // Open CC
        UIAlertAction *three = [UIAlertAction actionWithTitle:@"Lock Device" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[%c(ROLock) exec];}]; // Lock device
        UIAlertAction *four = [UIAlertAction actionWithTitle:@"Respring" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[%c(RORespring) exec];}]; // Respring device
        UIAlertAction *five = [UIAlertAction actionWithTitle:@"UICache" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[%c(ROUICache) exec];}]; // UICache device
        UIAlertAction *six = [UIAlertAction actionWithTitle:@"Enable/Disable WiFi" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[%c(ROWiFi) exec];}]; // Enable/Disable WiFi
        UIAlertAction *seven = [UIAlertAction actionWithTitle:@"Spotlight Search" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[%c(ROSpotlight) exec];}]; // Spotlight
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        // Without the "shouldCancel" part, as long as the tweak is enabled the sheet will initialize (even without any actions). I came up with this to solve it.
        if (ss) {
            [alert addAction:one];
            shouldCancel = TRUE;
        }
        if (cc) {
            [alert addAction:two];
            shouldCancel = TRUE;
        }
        if (lock) {
            [alert addAction:three];
            shouldCancel = TRUE;
        }
        if (respring) {
            [alert addAction:four];
            shouldCancel = TRUE;
        }
        if (uicache) {
            [alert addAction:five];
            shouldCancel = TRUE;
        }
        if (wifi) {
            [alert addAction:six];
            shouldCancel = TRUE;
        }
        if (spotlight) {
            [alert addAction:seven];
            shouldCancel = TRUE;
        }
        if (shouldCancel) {
            [alert addAction:reach];
            [alert addAction:cancel];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    // If the tweak isn't enabled, just open reachability as normal.
    } else {
        %orig;
    }
}

%end

// Loads prefs and inits
%ctor {
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ajaidan.reachoptionsprefs"];
    [preferences registerBool:&isEnabled default:NO forKey:@"isEnabled"];
	[preferences registerBool:&ss default:NO forKey:@"1"];
	[preferences registerBool:&cc default:NO forKey:@"2"];
	[preferences registerBool:&lock default:NO forKey:@"3"];
	[preferences registerBool:&respring default:NO forKey:@"4"];
	[preferences registerBool:&uicache default:NO forKey:@"5"];
    [preferences registerBool:&wifi default:NO forKey:@"6"];
    [preferences registerBool:&spotlight default:NO forKey:@"7"];
}
