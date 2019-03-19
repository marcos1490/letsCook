//
//  WebServiceManager.m
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import "WebServiceManager.h"
#import "AFNetworking.h"

#define kWebService_Base_URL            @"https://gl-endpoint.herokuapp.com"
#define kWebService_Recipes_List        @"/recipes"
#define kWebService_Recipe_Detail       @"/recipes/"

@implementation WebServiceManager

+ (AFHTTPSessionManager*)getRequestManager
{
    NSURL *baseURL = [NSURL URLWithString:kWebService_Base_URL];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}


+(void)getRecipesWithCompletion:(void(^)(NSArray *recipes))completion andError:(void(^)(NSError *error))errorBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kWebService_Base_URL, kWebService_Recipes_List];
    AFHTTPSessionManager *manager = [self getRequestManager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, NSArray *responseObject) {
        NSMutableArray *recipes = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in responseObject) {
            NSError *parsingError;
            Recipe *recipe = [MTLJSONAdapter modelOfClass:Recipe.class fromJSONDictionary:dict error:&parsingError];
            if (recipe != nil) {
                [recipes addObject:recipe];
            }
        }
        completion(recipes);
    } failure:^(NSURLSessionTask *task, NSError *error) {
        errorBlock(error);
    }];
}

+(void)getRecipeDetail:(NSNumber *)recipe withCompletion:(void(^)(RecipeDetail *recipe))completion andError:(void(^)(NSError *error))errorBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", kWebService_Base_URL, kWebService_Recipe_Detail, recipe];
    AFHTTPSessionManager *manager = [self getRequestManager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        
        NSError *parsingError;
        RecipeDetail *recipe = [MTLJSONAdapter modelOfClass:RecipeDetail.class fromJSONDictionary:responseObject error:&parsingError];
        if (recipe == nil) {
            errorBlock(parsingError);
        } else {
            completion(recipe);
        }
        
        
    } failure:^(NSURLSessionTask *task, NSError *error) {
        errorBlock(error);
    }];
}

@end
