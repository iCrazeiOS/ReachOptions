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

// WiFi
+(void)WiFi {
    BOOL wiFiEnabled = [[%c(SBWiFiManager) sharedInstance] wiFiEnabled];
    [[%c(SBWiFiManager) sharedInstance] setWiFiEnabled:!wiFiEnabled];
}

// Custom Command
+(void)CustomCommand {
    // Add text box
    UIAlertController * textBox = [UIAlertController alertControllerWithTitle: @"Custom command" message: @"Input custom command here." preferredStyle:UIAlertControllerStyleAlert];
    [textBox addTextFieldWithConfigurationHandler:^(UITextField *commandField) {commandField.placeholder = @"launchctl reboot userspace"; commandField.textColor = [UIColor blueColor]; commandField.clearButtonMode = UITextFieldViewModeWhileEditing; commandField.borderStyle = UITextBorderStyleRoundedRect;}];
    [textBox addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = textBox.textFields;
        UITextField * commandfield = textfields[0];
        // Run as root
        setuid(0);
        // Actually run command
        NSTask *task = [[NSTask alloc] init];
		[task setLaunchPath:@"/bin/sh"];
        [task setArguments:@[@"-c", @"%@", commandfield.text]];
		[task launch];
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:textBox animated:YES completion:nil];
}

@end