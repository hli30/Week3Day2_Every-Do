//
//  CustomTableViewCell.h
//  Every.Do
//
//  Created by Harry Li on 2017-06-13.
//  Copyright © 2017 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *todoTitle;
@property (weak, nonatomic) IBOutlet UILabel *todoDescription;
@property (weak, nonatomic) IBOutlet UILabel *todoPriority;


@end
