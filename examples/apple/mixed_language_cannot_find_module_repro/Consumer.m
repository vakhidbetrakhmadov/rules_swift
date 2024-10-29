#import "Consumer.h"
#import "examples/apple/mixed_language_cannot_find_module_repro/Consumer-Swift.h"

@implementation Consumer

+ (void)printHelloWorld {
    [HelloPrinterSwift print:@"there"];
}

@end
