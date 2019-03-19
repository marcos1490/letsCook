//
//  RecipeDetail.h
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "Mantle.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeDetail : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSNumber *recipeId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *instructions;

-(NSURL *)imageURL;

@end

NS_ASSUME_NONNULL_END
