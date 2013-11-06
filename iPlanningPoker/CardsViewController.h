//
//  CardsViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardsViewControllerDelegate;

@interface CardsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *cardValue;
@property (weak, nonatomic) IBOutlet UIButton *sendValueButton;

@end

@protocol CardsViewControllerDelegate <NSObject>


@end