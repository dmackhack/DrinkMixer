//
//  DetailedDrinkViewController.m
//  DrinkMixer
//
//  Created by David Mackenzie on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedDrinkViewController.h"


@implementation DetailedDrinkViewController

@synthesize drink=drink_, nameField=nameField_, descriptionView=descriptionView_, ingredientsView=ingredientsView_, drinkContentsScrollView=drinkContentsScrollView_, drinks=drinks_, popOver=popOver_;

- (void) refreshView
{
    NSLog(@"Refreshing view with DrinkName: %@", [drink_ objectForKey:NAME_KEY]);
    
    self.nameField.text = [self.drink objectForKey:NAME_KEY];
    self.descriptionView.text = [self.drink objectForKey:DESCRIPTION_KEY];
    self.ingredientsView.text = [self.drink objectForKey:INGREDIENTS_KEY];
}

- (void) drinkChanged:(NSDictionary *)newDrink
{
    self.drink = newDrink;
    [self refreshView];
    if (popOver_ != nil)
    {
        [popOver_ dismissPopoverAnimated:YES];
    }
}

#pragma mark - UISplitViewDelegate methods

// Called when a button should be added to a toolbar for a hidden view controller
- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc
{
    barButtonItem.title = @"Drinks";
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.popOver = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.popOver = nil;
}


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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardDidHideNotification object:nil];
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
    [drinks_ release];
    [drink_ release];
    [nameField_ release];
    [descriptionView_ release];
    [ingredientsView_ release];
    [drinkContentsScrollView_ release];
    [popOver_ release];
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
    return YES;
}

@end
