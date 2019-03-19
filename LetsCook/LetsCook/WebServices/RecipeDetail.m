//
//  RecipeDetail.m
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import "RecipeDetail.h"

@implementation RecipeDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"recipeId": @"id",
             @"title": @"title",
             @"rating": @"rating",
             @"image": @"image",
             @"instructions": @"instructions",
             };
}


-(NSURL *)imageURL {
    return [NSURL URLWithString:self.image];
}
@end
