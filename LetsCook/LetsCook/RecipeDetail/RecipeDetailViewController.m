//
//  RecipeDetailViewController.m
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "HCSStarRatingView.h"
#import "WebServiceManager.h"
#import "UIImageView+AFNetworking.h"

@interface RecipeDetailViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet HCSStarRatingView *ratingView;
@property (nonatomic, weak) IBOutlet UILabel *instructions;
@property (nonatomic, strong) RecipeDetail *recipe;
@end

@implementation RecipeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.recipe.title;
    self.ratingView.value = self.recipe.rating.floatValue;
    self.instructions.text = self.recipe.instructions;
    
    [self.image setImageWithURL:self.recipe.imageURL];
    self.extendedLayoutIncludesOpaqueBars = YES;
}

+(instancetype)instantiateWithRecipe:(RecipeDetail *)recipe {
    RecipeDetailViewController *vc =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RecipeDetailViewController"];
    vc.recipe = recipe;
    return vc;
}

@end
