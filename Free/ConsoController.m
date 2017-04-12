//
//  ConsoController.m
//  Free
//
//  Created by Anthony Fernandez on 28/03/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import "ConsoController.h"
#import "ConsoManager.h"
#import "Bill.h"
#import "ViewHelper2.h"
#import "ConsoCell.h"




#pragma mark - Conso Controller: Private Interface

@interface ConsoController () <UITableViewDelegate, UITableViewDataSource>

// Views
@property (nonatomic, weak) IBOutlet UITableView *consoTableView;
@property (nonatomic, weak) IBOutlet UIView *consoTableViewHeader;

@property (nonatomic, weak) IBOutlet UIView *consoDataContainer;
@property (nonatomic, weak) IBOutlet UILabel *consoPhoneNumberLabel;
@property (nonatomic, weak) IBOutlet UILabel *consoFromLabel;
@property (nonatomic, weak) IBOutlet UILabel *consoToLabel;

// Properties
@property (strong) Conso *conso;

@end




#pragma mark - Conso Controller: Implementation

@implementation ConsoController



#pragma mark Life Cycle

- (instancetype)initWithConso:(Conso *)conso {
    self = [super init];
    if (self) {
        self.conso = conso;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Fetch infos
    if (self.conso) {
        
        // Navigation bar
        self.title = NNIL(self.conso.fullname);
        
        NSString *forfaitSummary = [NSString stringWithFormat:@"%@ - %@", NNIL(self.conso.forfait), NNIL(self.conso.phoneNumber)];
        self.consoPhoneNumberLabel.text = NNIL(forfaitSummary);
        self.consoPhoneNumberLabel.textAlignment = NSTextAlignmentCenter;
        
        NSString *from = [NSString stringWithFormat:@"Du %@", self.conso.consoFrom];
        self.consoFromLabel.text = NNIL(from);
        
        NSString *to = [NSString stringWithFormat:@"Au %@", self.conso.consoTo];
        self.consoToLabel.text = NNIL(to);
        
        [self.consoTableView reloadData];
        
        [self generateDataVisualizer];
    }

    
    
    // Initialize table view
    self.consoTableView.tableHeaderView = self.consoTableViewHeader;
    [self.consoTableView registerNib:[UINib nibWithNibName:@"ConsoCell" bundle:nil] forCellReuseIdentifier:@"ConsoCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesBackButton = YES;
}




#pragma mark - UITableView Delegate: Implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Data
    // ----
    
    if (indexPath.row == 0) {
        ConsoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsoCell" forIndexPath:indexPath];
        [cell updateWithConsoType:ConsoTypeData conso:self.conso];
        
        return cell;
    }
    
    
    // Voice
    // -----
    
    else if (indexPath.row == 1) {
        ConsoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsoCell" forIndexPath:indexPath];
        [cell updateWithConsoType:ConsoTypeVoice conso:self.conso];
        
        return cell;
    }
    
    
    // SMS
    // ---
    
    else if (indexPath.row == 2) {
        ConsoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsoCell" forIndexPath:indexPath];
        [cell updateWithConsoType:ConsoTypeSMS conso:self.conso];
        
        return cell;
    }
    
    
    // MMS
    // ---
    
    else if (indexPath.row == 3) {
        ConsoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConsoCell" forIndexPath:indexPath];
        [cell updateWithConsoType:ConsoTypeMMS conso:self.conso];
        
        return cell;
    }
    
    
    return nil;
}




#pragma mark - Private methods: Data visualizer

- (void)generateDataVisualizer {
    
    UIView *viewMax = [[UIView alloc] initWithFrame:CGRectMake(8, 0, self.consoDataContainer.frame.size.width - 16, self.consoDataContainer.frame.size.height)];
    viewMax.backgroundColor =  RGBA(46, 61, 16, 0.6);
    viewMax.layer.cornerRadius = (self.consoDataContainer.frame.size.height / 2);
    
    UIView *viewCurrent = [[UIView alloc] initWithFrame:CGRectMake(8, 0, 0, self.consoDataContainer.frame.size.height)];
    viewCurrent.backgroundColor =  RGB(133, 194, 4);
    viewCurrent.layer.cornerRadius = (self.consoDataContainer.frame.size.height / 2);
    
    UILabel *labelConsoData = [[UILabel alloc] initWithFrame:CGRectMake(((self.consoDataContainer.bounds.size.width - 100) / 2), 0, 100, self.consoDataContainer.frame.size.height)];
    labelConsoData.backgroundColor = [UIColor clearColor];
    labelConsoData.textColor = [UIColor whiteColor];
    labelConsoData.text = NNIL(self.conso.dataConso);
    labelConsoData.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    
    [self.consoDataContainer addSubview:viewMax];
    [self.consoDataContainer addSubview:viewCurrent];
    [self.consoDataContainer addSubview:labelConsoData];
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = viewCurrent.frame;
        frame.size.width = (self.consoDataContainer.frame.size.width - 16) * (self.conso.dataPercent / 100);
        viewCurrent.frame = frame;
    }];
}


@end
