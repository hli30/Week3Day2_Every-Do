//
//  DetailViewController.m
//  Every.Do
//
//  Created by Harry Li on 2017-06-13.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "DetailViewController.h"
#import "Todo.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
    }
    [self configureView];

}


- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSString *intro = @"Todo Details:";
        NSString *title = [self.detailItem title];
        NSString *todoDescription = [self.detailItem todoDescription];
        NSString *priority = [self.detailItem priorityNumber];
        
        NSString *details = [NSString stringWithFormat:@"%@\n%@\n%@\nPriority: %@", intro, title, todoDescription, priority];
        
        self.detailDescriptionLabel.text = details;
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
