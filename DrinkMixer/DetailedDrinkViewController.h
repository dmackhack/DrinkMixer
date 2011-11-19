//
//  DetailedDrinkViewController.h
//  DrinkMixer
//
//  Created by David Mackenzie on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"


@interface DetailedDrinkViewController : UIViewController {
    
    NSMutableArray* drinks_;
    NSDictionary* drink_;
    UITextField* nameField_;
    UITextView* descriptionView_;
    UITextView* ingredientsView_;
    UIScrollView* drinkContentsScrollView_;
    BOOL keyboardVisible_;
    UIPopoverController* popOver_;
    
}

@property (nonatomic, retain) NSArray* drinks;
@property (nonatomic, retain) NSDictionary* drink;
@property (nonatomic, retain) IBOutlet UITextField* nameField;
@property (nonatomic, retain) IBOutlet UITextView* descriptionView;
@property (nonatomic, retain) IBOutlet UITextView* ingredientsView;
@property (nonatomic, retain) IBOutlet UIScrollView* drinkContentsScrollView;
@property (nonatomic, retain) IBOutlet UIPopoverController* popOver;

- (void) keyboardShown: (NSNotification*) notif;
- (void) keyboardHidden: (NSNotification*) notif;
- (void) refreshView;
- (void) drinkChanged: (NSDictionary *)newDrink;

@end
