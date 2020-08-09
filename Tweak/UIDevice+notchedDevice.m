#include "UIDevice+notchedDevice.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation UIDevice (notchedDevice)

-(BOOL)isNotched {

    if([self isAnIpod] || [self isAnIpad]) {
        return NO;
    }

    LAContext *context = [[LAContext alloc] init];

    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    return context.biometryType == LABiometryTypeFaceID;
}

-(BOOL)isAnIpad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

-(BOOL)isAnIpod {
    NSString const *model = [UIDevice.currentDevice model];
    return ([model isEqualToString:@"iPod"]);
}

@end
