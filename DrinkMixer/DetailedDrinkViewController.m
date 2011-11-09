//
//  DetailedDrinkViewController.m
//  DrinkMixer
//
//  Created by David Mackenzie on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedDrinkViewController.h"


@implementation DetailedDrinkViewController

@synthesize drink=drink_, nameField=nameField_, descriptionView=descriptionView_, ingredientsView=ingredientsView_, drinkContentsScrollView=drinkContentsScrollView_;


- (void) keyboardShown: (NSNotification*) notif
{
    NSLog(@"keyboard shown");
    
    if (keyboardVisible_) 
    {
        NSLog(@"%@", @"Keyboard is already visible. Ignoring notification.");
        return;
    }
    
    NSLog(@"Resizing smaller for keyboard");
    
    NSDictionary *info = [notif userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // gets the top of the keyboard
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    
    // 
    CGRect viewFrame = self.view.bounds;
    viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    self.drinkContentsScrollView.frame = viewFrame;
    keyboardVisible_ = YES;
  
}

- (void) keyboardHidden: (NSNotification*) notif
{
    NSLog(@"keyboard hidden");
    
    if (!keyboardVisible_)
    {
        NSLog(@"%@", @"Keyboard already hidden. Ignoring notification.");
        return;
    }
    
    NSLog(@"%@", @"Resizing bigger with no keyboard");
    
    self.drinkContentsScrollView.frame = self.view.bounds;
    keyboardVisible_ = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    NSLog(@"DrinkName: %@", [drink_ objectForKey:NAME_KEY]);
    
    self.nameField.text = [drink_ objectForKey:NAME_KEY];
    self.descriptionView.text = [drink_ objectForKey:DESCRIPTION_KEY];
    self.ingredientsView.text = [drink_ objectForKey:INGREDIENTS_KEY];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidDisappear:animated];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [nameField_ release];
    [descriptionView_ release];
    [ingredientsView_ release];
    [drinkContentsScrollView_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.drinkContentsScrollView.contentSize = self.view.frame.size;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [drink_ release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
