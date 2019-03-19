//
//  Recipe.m
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"recipeId": @"id",
             @"title": @"title"
             };
}
@end
