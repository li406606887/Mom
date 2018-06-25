//
//  QHRequest.m
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//


#import "QHRequest.h"


@implementation QHRequest

static QHRequest *requestManager ;

+ (instancetype)request {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[self alloc] init];
    });
    return requestManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.operationManager = [AFHTTPSessionManager manager];
    }
    return self;
}



- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)(QHRequest * request, id response))success
    failure:(void (^)(QHRequest * request, NSError *error))failure {
    
    self.operationQueue=self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    self.operationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        NSString *token =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        if (token) {
            [self.operationManager.requestSerializer setValue:[NSString stringWithFormat:@"%@",token]  forHTTPHeaderField:@"Token"];
    
        }
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.operationManager.requestSerializer setValue:@"4" forHTTPHeaderField:@"Platform"];
    [self.operationManager.requestSerializer setValue:version forHTTPHeaderField:@"Version_Code"];
    
    // 设置超时时间
    self.operationManager.requestSerializer.timeoutInterval = 10.f;
    [self.operationManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self.operationManager GET:URLString
                    parameters:parameters
                      progress:^(NSProgress * _Nonnull downloadProgress) {
                          
                      }
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           id object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                           
                           success(self,object);
                           dispatch_semaphore_signal(semaphore);
                           
                       }
                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           failure(self,error);
                           dispatch_semaphore_signal(semaphore);
                       }
     ];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(QHRequest *request, id response))success
     failure:(void (^)(QHRequest *request, NSError *error))failure{
    
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.requestSerializer.timeoutInterval = 10.f;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *token =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.operationManager.requestSerializer setValue:@"4" forHTTPHeaderField:@"Platform"];
    [self.operationManager.requestSerializer setValue:version forHTTPHeaderField:@"Version_Code"];
    if (token) {
        [self.operationManager.requestSerializer setValue:[NSString stringWithFormat:@"%@",token]  forHTTPHeaderField:@"Token"];
        
    }
    // 设置超时时间
    self.operationManager.requestSerializer.timeoutInterval = 10.f;
    [self.operationManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self.operationManager POST:URLString
                     parameters:parameters
                       progress:^(NSProgress * _Nonnull uploadProgress) {
                           
                       }
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            id object;
                            if ([responseObject isKindOfClass:[NSData class]]) {
                                object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                            }else{
                                object =responseObject;
                            }
                            success(self,object);
                            if ([object[@"Code"] intValue]==405) {
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phoneNumber"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                            dispatch_semaphore_signal(semaphore);
                            
                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            failure(self,error);
                            dispatch_semaphore_signal(semaphore);
                            
                        }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
}

- (void)DELETE:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(QHRequest *request, id response))success
     failure:(void (^)(QHRequest *request, NSError *error))failure {
    
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.requestSerializer.timeoutInterval = 10.f;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSString *token =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self.operationManager.requestSerializer setValue:@"4" forHTTPHeaderField:@"Platform"];
    [self.operationManager.requestSerializer setValue:version forHTTPHeaderField:@"Version_Code"];
    if (token) {
        [self.operationManager.requestSerializer setValue:[NSString stringWithFormat:@"%@",token]  forHTTPHeaderField:@"Token"];
        
    }
    // 设置超时时间
    self.operationManager.requestSerializer.timeoutInterval = 10.f;
    [self.operationManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self.operationManager DELETE:URLString
                       parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           id object;
                           if ([responseObject isKindOfClass:[NSData class]]) {
                               object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                           }else{
                               object =responseObject;
                           }
                           
                           success(self,object);
                           if ([object[@"Code"] intValue]==405) {
                               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
                               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phoneNumber"];
                               [[NSUserDefaults standardUserDefaults] synchronize];
                           }
                           dispatch_semaphore_signal(semaphore);

                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           failure(self,error);
                           dispatch_semaphore_signal(semaphore);
                       }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
}

+ (BOOL)isValidateString:(NSString*)str {
        
    if (str == nil)
    {
        return NO;
    }
    
    if ([str isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    
    if ([str isEqualToString:@""])
    {
        return NO;
    }
    if ([str isEqualToString:@"null"]) {
        return NO;
    }
    
    if ([str isEqualToString:@"<null>"]) {
        return NO;
    }
    
    if ([str length] == 0)
    {
        return NO;
    }
    
    return YES;
}

- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters {
    
    [self POST:URLString
    parameters:parameters
       success:^(QHRequest *request, id  response) {
           if ([self.delegate respondsToSelector:@selector(QHRequest:finished:)]) {
               [self.delegate QHRequest:request finished:response];
               
           }
       }
       failure:^(QHRequest *request, NSError *error) {
           if ([self.delegate respondsToSelector:@selector(QHRequest:Error:)]) {
               [self.delegate QHRequest:request Error:error.description];
           }
       }];
}

- (void)getWithURL:(NSString *)URLString {
    
    [self GET:URLString parameters:nil success:^(QHRequest *request, id response) {
        if ([self.delegate respondsToSelector:@selector(QHRequest:finished:)]) {
            [self.delegate QHRequest:request finished:response];
        }
    } failure:^(QHRequest *request, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(QHRequest:Error:)]) {
            [self.delegate QHRequest:request Error:error.description];
        }
    }];
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSString *)arrayToJSONString:(NSArray *)array {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return jsonString;
}
@end
