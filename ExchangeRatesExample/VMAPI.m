//
//  VMAPI.m
//  ExchangeRatesExample
//
//  Created by Artem Shilin on 17.10.15.
//  Copyright (c) 2015 Artem Shilin. All rights reserved.
//

#import "VMAPI.h"
#import <AFNetworking/AFNetworking.h>
#import <Objection/Objection.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString * const VMAPIBaseUrl = @"https://api.fixer.io/";

@interface VMAPI ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation VMAPI
objection_register_singleton(VMAPI)

- (void)awakeFromObjection {
    [super awakeFromObjection];
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:VMAPIBaseUrl]];
}

- (RACSignal *)getPath:(NSString *)path withParams:(NSDictionary *)params {
    return [self p_requestPath:path method:@"GET" params:params];
}

- (RACSignal *)postPath:(NSString *)path withParams:(NSDictionary *)params {
    return [self p_requestPath:path method:@"POST" params:params];
}

- (RACSignal *)p_requestPath:(NSString *)path method:(NSString *)method params:(NSDictionary *)params {
    
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self)
        
        NSError *error = nil;
        NSString *fullPath = [[NSURL URLWithString:path relativeToURL:self.manager.baseURL] absoluteString];
        NSMutableURLRequest *request = [[self.manager requestSerializer] requestWithMethod:method URLString:fullPath parameters:params error:&error];
        
        if (error) {
            [subscriber sendError:error];
            return nil;
        }
        
        request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [request setTimeoutInterval:15.f];
        [request setHTTPShouldHandleCookies:NO];
        
        NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *responseError) {
            if (responseError) {
                [subscriber sendError:responseError];
            } else {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
        }];
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

@end
