//
//  WebServiceManager.h
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "RecipeDetail.h"

NS_ASSUME_NONNULL_BEGIN
@protocol RequestProtocol <NSObject>

-(NSString *)path;

@end
@interface WebServiceManager : NSObject
+(void)getRecipesWithCompletion:(void(^)(NSArray *recipes))completion andError:(void(^)(NSError *error))errorBlock ;
+(void)getRecipeDetail:(NSNumber *)recipe withCompletion:(void(^)(RecipeDetail *recipe))completion andError:(void(^)(NSError *error))errorBlock;
@end

NS_ASSUME_NONNULL_END
