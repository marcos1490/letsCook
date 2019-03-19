//
//  RecipeDetailViewController.h
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeDetailViewController : UIViewController
+(instancetype)instantiateWithRecipe:(RecipeDetail *)recipe;
@end

NS_ASSUME_NONNULL_END
