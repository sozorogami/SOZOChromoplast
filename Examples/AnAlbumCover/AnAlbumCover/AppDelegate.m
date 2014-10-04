#import "AppDelegate.h"
#import "SOZOAlbumCoverViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [SOZOAlbumCoverViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
