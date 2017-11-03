//
//  do_SMSVerificationCode_App.m
//  DoExt_SM
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_SMSVerificationCode_App.h"
#import "SMS_SDK.framework/Headers/SMSSDK.h"
#import "doServiceContainer.h"
#import "doIModuleExtManage.h"
static do_SMSVerificationCode_App* instance;
@implementation do_SMSVerificationCode_App
@synthesize OpenURLScheme;
+(id) Instance
{
    if(instance==nil)
        instance = [[do_SMSVerificationCode_App alloc]init];
    return instance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化SDK
    NSString * appKey = [[doServiceContainer Instance].ModuleExtManage GetThirdAppKey:@"do_SMSverificationCode.plist" :@"MOBAppKey"];
    NSString * appSecret = [[doServiceContainer Instance].ModuleExtManage GetThirdAppKey:@"do_SMSverificationCode.plist" :@"MOBAppSecret"];
    [SMSSDK registerApp:appKey withSecret:appSecret];
    
    return YES;
}

@end
