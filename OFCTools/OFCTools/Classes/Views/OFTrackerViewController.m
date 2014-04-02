//
//  OFTrackerViewController.m
//  OFCTools
//
//  Created by Julien Tran on 02/04/14.
//  Copyright (c) 2014 Julien Tran. All rights reserved.
//

#import "OFTrackerViewController.h"

@interface OFTrackerViewController ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@end

@implementation OFTrackerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
}

- (void)setupScrollView
{
    NSArray *suitList = @[@"s", @"c", @"d", @"h"];
    int contentWidth = 0;
    int contentHeight = 0;
    for (int suitID=0; suitID<suitList.count; suitID++)
    {
        contentWidth = 0;
        NSString *suitName = suitList[suitID];
        for (int rank=1; rank<=13; rank++)
        {
            UIImage *cardImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d%@.gif", rank, suitName]];
            UIButton *cardButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [cardButton setImage:cardImage forState:UIControlStateNormal];
            cardButton.layer.borderColor = [UIColor grayColor].CGColor;
            cardButton.layer.borderWidth = 1;
            cardButton.layer.cornerRadius = 5;
            
            CGRect cardFrame = cardButton.frame;
            cardFrame.size.width = cardImage.size.width/2;
            cardFrame.size.height = cardImage.size.height/2;
            cardFrame.origin.x = (rank-1) * (cardFrame.size.width + 2);
            cardFrame.origin.y = suitID * (cardFrame.size.height + 2);
            cardButton.frame = cardFrame;
            
            [self.scrollView addSubview:cardButton];

            contentWidth += (cardFrame.size.width + 2);
            if (1 == rank)
                contentHeight += (cardFrame.size.height + 2);
            
            [cardButton addTarget:self action:@selector(cardDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
}

- (void)cardDidSelect:(UIButton*)cardButton
{
    cardButton.alpha = 1.1 - cardButton.alpha;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resetButtonDidClick:(id)sender
{
    for (UIButton *cardButton in self.scrollView.subviews)
        cardButton.alpha = 1;
}

@end
