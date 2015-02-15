//
//  DetailViewController.h
//  RageQuit
//
//  Created by Jonathan Kingsley on 15/02/2015.
//  Copyright (c) 2015 Jonathan Kingsley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

