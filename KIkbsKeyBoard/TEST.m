//
//  TEST.m
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/8/12.
//

#import "TEST.h"

@interface ManagerTool ()

@end

@implementation ManagerTool

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (NSInteger)numberWithHexString:(NSString *)hexString {

    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}

@end
