//
//  MasterViewController.m
//  Roopyesh
//
//  Created by Amir on 8/22/17.
//  Copyright © 2017 Emersad. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *premieredLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = self.movieName;
    self.imageView.image = self.image;
    self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %@", self.rating];
    self.languageLabel.text = [NSString stringWithFormat:@"Language: %@", self.language];
    self.premieredLabel.text = [NSString stringWithFormat:@"Premiered: %@", self.premiered];
    self.summaryLabel.text = [NSString stringWithFormat:@"Summary: %@", self.summary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
