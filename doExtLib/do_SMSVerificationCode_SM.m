//
//  do_SMSVerificationCode_SM.m
//  DoExt_API
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_SMSVerificationCode_SM.h"

#import "doScriptEngineHelper.h"
#import "doIScriptEngine.h"
#import "doInvokeResult.h"
#import "doJsonHelper.h"
#import "doILogEngine.h"
#import "doServiceContainer.h"
#import "doIModuleExtManage.h"
#import "SMS_SDK.framework/Headers/SMSSDK.h"

@interface do_SMSVerificationCode_SM()
@property (nonatomic, assign) BOOL sendResult;
@property (nonatomic, assign) BOOL verityResult;
@end

@implementation do_SMSVerificationCode_SM
#pragma mark - 方法
#pragma mark - 同步异步方法的实现

//同步
//异步
- (void)getSMSVerificationCode:(NSArray *)parms
{
    //异步耗时操作，但是不需要启动线程，框架会自动加载一个后台线程处理这个函数
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    
    NSString * phoneNumberStr = [doJsonHelper GetOneText:_dictParas :@"phoneNumber" :@""];
//    if (phoneNumberStr.length != 11) {
//        [[doServiceContainer Instance].LogEngine WriteError:nil :@"电话号码输入有误"];
//        return;
//    }

    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumberStr zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"验证码已发送");
            //参数字典_dictParas
            id<doIScriptEngine> _scritEngine = [parms objectAtIndex:1];
            //自己的代码实现

            NSString *_callbackName = [parms objectAtIndex:2];
            //回调函数名_callbackName
            doInvokeResult *_invokeResult = [[doInvokeResult alloc] init];
            //_invokeResult设置返回值

            NSDictionary * dict = @{@"result":@"true"};
            [_invokeResult SetResultNode:dict];

            [_scritEngine Callback:_callbackName :_invokeResult];
        } else {
            NSLog(@"错误信息:%@", error);
//            NSString * errStr = [NSString stringWithFormat:@"错误信息:%@", error];
//            [[doServiceContainer Instance].LogEngine WriteError:nil :errStr];
            //参数字典_dictParas
            id<doIScriptEngine> _scritEngine = [parms objectAtIndex:1];
            //自己的代码实现

            NSString *_callbackName = [parms objectAtIndex:2];
            //回调函数名_callbackName
            doInvokeResult *_invokeResult = [[doInvokeResult alloc] init];
            //_invokeResult设置返回值
            
//            NSInteger errorCode = error.code;
//            NSString * errCodeStr = [NSString stringWithFormat:@"%ld", (long)errorCode];
            
            NSString * errorStr = error.description;
            NSDictionary * dict = @{@"result":@"false",@"errorMessage":errorStr};
            [_invokeResult SetResultNode:dict];
            
            [_scritEngine Callback:_callbackName :_invokeResult];
        }
    }];
   

}
- (void)verifySMSVerificationCode:(NSArray *)parms
{
    //异步耗时操作，但是不需要启动线程，框架会自动加载一个后台线程处理这个函数
    NSDictionary *_dictParas = [parms objectAtIndex:0];
    
    NSString * code = [doJsonHelper GetOneText:_dictParas :@"code" :@""];
    NSString * phoneNumberStr = [doJsonHelper GetOneText:_dictParas :@"phoneNumber" :@""];
    
    [SMSSDK commitVerificationCode:code phoneNumber:phoneNumberStr zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        if (!error) {
            NSLog(@"验证成功");
            //参数字典_dictParas
            id<doIScriptEngine> _scritEngine = [parms objectAtIndex:1];
            //自己的代码实现
            
            NSString *_callbackName = [parms objectAtIndex:2];
            //回调函数名_callbackName
            doInvokeResult *_invokeResult = [[doInvokeResult alloc] init];
            //_invokeResult设置返回值
            
            NSDictionary * dict = @{@"result":@"true"};
            [_invokeResult SetResultNode:dict];
            
            [_scritEngine Callback:_callbackName :_invokeResult];
        } else {
            NSLog(@"错误信息:%@", error);
//            NSString * errStr = [NSString stringWithFormat:@"错误信息:%@", error];
//            [[doServiceContainer Instance].LogEngine WriteError:nil :errStr];
            //参数字典_dictParas
            id<doIScriptEngine> _scritEngine = [parms objectAtIndex:1];
            //自己的代码实现
            
            NSString *_callbackName = [parms objectAtIndex:2];
            //回调函数名_callbackName
            doInvokeResult *_invokeResult = [[doInvokeResult alloc] init];
            //_invokeResult设置返回值
            
//            NSInteger errorCode = error.code;
//            NSString * errCodeStr = [NSString stringWithFormat:@"%ld", (long)errorCode];
            
            NSString * errorStr = error.description;
            NSDictionary * dict = @{@"result":@"false",@"errorMessage":errorStr};
            [_invokeResult SetResultNode:dict];
            
            [_scritEngine Callback:_callbackName :_invokeResult];
        }
    }];
}

@end
