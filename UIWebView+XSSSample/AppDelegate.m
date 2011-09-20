//
//  AppDelegate.m
//  UIWebView+XSSSample


#import "AppDelegate.h"

#import "RootViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
  [_window release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  
  self.window.rootViewController = [[[RootViewController alloc] init] autorelease];
  
  return YES;
}


@end
