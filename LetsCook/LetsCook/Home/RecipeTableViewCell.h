//
//  RecipeTableViewCell.h
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecipeTableViewCell : UITableViewCell
-(void)configureWithRecipe:(Recipe *)recipe;
@end

NS_ASSUME_NONNULL_END
