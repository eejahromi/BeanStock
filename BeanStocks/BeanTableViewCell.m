//
//  BeanTableViewCell.m
//  BeanStocks
//
//  Created by William Lundy on 11/5/15.
//  Copyright © 2015 Ehsan Jahromi. All rights reserved.
//

#import "BeanTableViewCell.h"

@interface BeanTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation BeanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.nameLabel.text = self.bean.name;
    self.rssiLabel.text = [self.bean.RSSI stringValue];
    NSString* state;
    switch (self.bean.state) {
        case BeanState_Unknown:
            state = @"Unknown";
            break;
        case BeanState_Discovered:
            state = @"Disconnected";
            break;
        case BeanState_AttemptingConnection:
            state = @"Connecting...";
            break;
        case BeanState_AttemptingValidation:
            state = @"Connecting...";
            break;
        case BeanState_ConnectedAndValidated:
            state = @"Connected";
            break;
        case BeanState_AttemptingDisconnection:
            state = @"Disconnecting...";
            break;
        default:
            state = @"Invalid";
            break;
    }
    self.statusLabel.text = state;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
