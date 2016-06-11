#import "AppDelegate.h"
#import "PonyDebugger-Swift.h"

@interface AppDelegate ()
@property (nonatomic) PonyDServer *server;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _server = [[PonyDServer alloc] init];
    [self.server startServer];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    [self.server stop];
}

@end
