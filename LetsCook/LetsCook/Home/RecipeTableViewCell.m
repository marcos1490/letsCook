//
//  RecipeTableViewCell.m
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import "RecipeTableViewCell.h"
@interface RecipeTableViewCell()
@property (nonatomic, weak) IBOutlet UILabel *name;
@end

@implementation RecipeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configureWithRecipe:(Recipe *)recipe {
    self.name.text = recipe.title;
}

@end
