//
//  MasterViewController.m
//  Every.Do
//
//  Created by Harry Li on 2017-06-13.
//  Copyright © 2017 Harry. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "CustomTableViewCell.h"
#import "AddTodoViewController.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource, AddTodoViewControllerDelegate>

@property (nonatomic) NSMutableArray *objects;
@property (nonatomic) UISwipeGestureRecognizer *swipe;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self setupTodos];
}


- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self performSegueWithIdentifier:@"addTodo" sender:nil];
}


#pragma mark - Delegate

-(void)passInfo:(NSArray *)userInfo{
    NSString *title = userInfo[0];
    NSString *todoDescription = userInfo[1];
    NSString *priority = userInfo[2];
    Todo *todo = [[Todo alloc] initWithTitle:title andDescription:todoDescription andPriorityNumber:priority];
    
    [self.objects insertObject:todo atIndex:0];
    [self.tableView reloadData];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
    }
    if ([[segue identifier] isEqualToString:@"addTodo"]) {
        AddTodoViewController *ToDoController = (AddTodoViewController *)[segue destinationViewController];
        ToDoController.delegate = self;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
    [cell addGestureRecognizer:swipe];
    
    NSString *todo = [self.objects[indexPath.row] title];
    NSString *todoDescription =[self.objects[indexPath.row] todoDescription];
    NSString *priority = [NSString stringWithFormat:@"Priority: %@", [self.objects[indexPath.row] priorityNumber]];
    
    if ([self.objects[indexPath.row] isCompleted] == NO) {
        cell.todoTitle.text = todo;
        cell.todoDescription.text = todoDescription;
        cell.todoPriority.text = priority;
        return cell;
    }else{
        NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSAttributedString* attributedTodo = [[NSAttributedString alloc] initWithString:todo attributes:attributes];
        NSAttributedString* attributedDescription = [[NSAttributedString alloc] initWithString:todoDescription attributes:attributes];
        NSAttributedString* attributedPriority = [[NSAttributedString alloc] initWithString:priority attributes:attributes];
        
        cell.todoTitle.attributedText = attributedTodo;
        cell.todoDescription.attributedText = attributedDescription;
        cell.todoPriority.attributedText = attributedPriority;
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)swiped:(UISwipeGestureRecognizer *)sender{
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    NSInteger currentRow = swipedIndexPath.row;
    [self.objects[currentRow] setIsCompleted:YES];
    NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:self.objects.count-1 inSection:0];
    
    Todo *temp = self.objects[currentRow];
    [self.objects removeObjectAtIndex:currentRow];
    [self.objects addObject:temp];
    [self.tableView moveRowAtIndexPath:swipedIndexPath toIndexPath:bottomIndexPath];
    [self.tableView reloadData];
}


#pragma mark -- Initialize Todo Objects

- (void)setupTodos{
    Todo *todo1 = [[Todo alloc] initWithTitle:@"Buy groceries" andDescription:@"Buy food" andPriorityNumber:@"2"];
    Todo *todo2 = [[Todo alloc] initWithTitle:@"Do work" andDescription:@"Finish work" andPriorityNumber:@"1"];
    Todo *todo3 = [[Todo alloc] initWithTitle:@"Exercise" andDescription:@"Go biking" andPriorityNumber:@"3"];
    Todo *todo4 = [[Todo alloc] initWithTitle:@"Clean" andDescription:@"Clean home" andPriorityNumber:@"4"];
    
    self.objects = [[NSMutableArray alloc] initWithArray:@[todo1, todo2, todo3, todo4]];
}

@end
