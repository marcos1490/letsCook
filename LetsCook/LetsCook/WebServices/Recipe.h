//
//  Recipe.h
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "Mantle.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recipe : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSNumber *recipeId;
@property (nonatomic, strong) NSString *title;
@end

NS_ASSUME_NONNULL_END
