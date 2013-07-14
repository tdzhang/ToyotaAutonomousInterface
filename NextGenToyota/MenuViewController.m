//
//  MenuViewController.m
//  NextGenToyota
//
//  Created by Michael Chun on 2/21/13.
//  Copyright (c) 2013 Chime Lab. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    CGRect myFrame = self.view.frame;
    myFrame.size.height = ((UITableView*)self.view).rowHeight * [((UITableView*)self.view) numberOfRowsInSection:0];
    myFrame.origin.y = (self.view.frame.size.height - myFrame.size.height) / 2;
    self.view.frame = myFrame;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    [recognizer setNumberOfTapsRequired:1];
    recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
    [self.view.window addGestureRecognizer:recognizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Menu selected... %d", indexPath.row);
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{   
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [sender locationInView:nil]; //Passing nil gives us coordinates in the window
        
        //Then we convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.

        if (![self.view.superview pointInside:[self.view.superview convertPoint:location fromView:self.view.window] withEvent:nil])
        {
            [self dismissModalViewControllerAnimated:YES];
        }
    }
}

-(void)dismissModalViewControllerAnimated:(BOOL)animated
{
    [self.view.window removeGestureRecognizer:recognizer];
    [super dismissModalViewControllerAnimated:animated];
}
@end
