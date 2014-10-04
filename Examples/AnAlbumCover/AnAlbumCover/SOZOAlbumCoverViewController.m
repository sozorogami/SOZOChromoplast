#import "SOZOAlbumCoverViewController.h"
#import <SOZOChromoplast/SOZOChromoplast.h>
#import "SOZOImageScrollView.h"
#import "SOZOSwatchContainerView.h"
#import "UIView+SOZOAutoLayoutHelpers.h"

@interface SOZOAlbumCoverViewController () <SOZOImageScrollViewDelegate>
@property (strong, nonatomic) SOZOImageScrollView *imageScrollView;
@property (strong, nonatomic) SOZOSwatchContainerView *swatchView;
@property (strong, nonatomic) UIView *labelContainerView;
@property (assign, nonatomic) float margin;
@property (strong, nonatomic) NSArray *albumData;

@property (strong, nonatomic) NSArray *allLabels;
@property (strong, nonatomic) NSArray *headerLabels;
@property (strong, nonatomic) NSArray *contentLabels;

@end

@implementation SOZOAlbumCoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self loadAlbumData];
    [self initializeSubviews];
    [self initializeLabels];
    [self updateViewWithAlbumDataAtIndex:0];
    [self configureLayout];
}

- (void)configureView {
    [self setMargin:15.f];
    self.view = [self.view forAutolayout];
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)loadAlbumData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"albumData" ofType:@"plist"];
    self.albumData = [NSArray arrayWithContentsOfFile:plistPath];
}

- (void)initializeSubviews {
    [self initializeSwatchView];
    [self initializeImageScrollView];
}

- (void)initializeSwatchView {
    self.swatchView = [[SOZOSwatchContainerView new] forAutolayout];
    [self.view addSubview:self.swatchView];
}

- (void)initializeImageScrollView {
    self.imageScrollView = [[[SOZOImageScrollView alloc] initWithImages:[self albumCoverImages]] forAutolayout];
    [self.imageScrollView setUpdateDelegate:self];
    [self.view addSubview:self.imageScrollView];
}

- (NSArray *)albumCoverImages {
    NSArray *filenames = [self.albumData valueForKey:@"coverFilename"];
    NSMutableArray *images = [NSMutableArray new];
    for (NSString *filename in filenames) {
        [images addObject:[UIImage imageNamed:filename]];
    }
    return images;
}

- (void)initializeLabels {
    self.labelContainerView = [[UIView new] forAutolayout];
    [self.labelContainerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.labelContainerView];

    self.titleLabel = [[UILabel new] forAutolayout];
    self.titleLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Heavy" size:26.f];
    [self.labelContainerView addSubview:self.titleLabel];

    self.header1 = [self headerLabel];
    [self.labelContainerView addSubview:self.header1];

    self.content1 = [self contentLabel];
    [self.labelContainerView addSubview:self.content1];

    self.header2 = [self headerLabel];
    self.header2.text = @"Fun Fact";
    [self.labelContainerView addSubview:self.header2];

    self.content2 = [self contentLabel];
    [self.labelContainerView addSubview:self.content2];

    self.contentLabels = @[self.content1, self.content2];
    self.headerLabels = @[self.header1, self.header2];
    self.allLabels = [[@[self.titleLabel]   arrayByAddingObjectsFromArray:self.contentLabels]
                                            arrayByAddingObjectsFromArray:self.headerLabels];
}

- (void)configureLayout {
    [self.view pinSubview:self.swatchView toTopWithPadding:[self topMargin]];
    [self.view pinSubview:self.swatchView toRightSideWithPadding:self.margin];
    [self.view pinSubview:self.swatchView toBottomWithPadding:self.margin];
    [self.view attachSubview:self.swatchView toRightSideOfSubview:self.imageScrollView withPadding:self.margin];

    [self.view pinSubview:self.imageScrollView toLeftSideWithPadding:self.margin];
    [self.view pinSubview:self.imageScrollView toTopWithPadding:[self topMargin]];

    [self.view attachSubview:self.labelContainerView toBottomOfSubview:self.imageScrollView withPadding:self.margin];
    [self.view pinSubview:self.labelContainerView toLeftSideWithPadding:self.margin];
    [self.view attachSubview:self.swatchView toRightSideOfSubview:self.labelContainerView withPadding:self.margin];

    [self.view addConstraint:[self containerBottomToViewBottomConstraint]];
    [self.view addConstraint:[self keepLabelContainerHeightReasonableConstraint]];
    [self configureLayoutInsideLabelContainerView];
}

- (void)configureLayoutInsideLabelContainerView {
    [self.labelContainerView evenlyDistributeViewsVerticallyInside:[@[self.titleLabel] arrayByAddingObjectsFromArray:self.contentLabels]];
    [self.labelContainerView centerSubviewHorizontallyInside:self.titleLabel];
    [self.labelContainerView leftAlignViewsInside:self.headerLabels withPadding:self.margin];
    [self.labelContainerView leftAlignViewsInside:self.contentLabels withPadding:self.margin*2];
    [self.labelContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.content1
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.labelContainerView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:1
                                                                         constant:-self.margin*3]];
    [self.labelContainerView addConstraint:[NSLayoutConstraint constraintWithItem:self.content2
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.labelContainerView
                                                                        attribute:NSLayoutAttributeWidth
                                                                       multiplier:1
                                                                         constant:-self.margin*3]];
    [self.labelContainerView attachSubview:self.content1 toBottomOfSubview:self.header1 withPadding:0];
    [self.labelContainerView attachSubview:self.content2 toBottomOfSubview:self.header2 withPadding:0];
}

- (NSLayoutConstraint *)containerBottomToViewBottomConstraint {
    NSLayoutConstraint *containerBottomToViewBottomConstraint = [NSLayoutConstraint constraintWithItem:self.labelContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:-self.margin];
    [containerBottomToViewBottomConstraint setPriority:UILayoutPriorityDefaultLow];
    return containerBottomToViewBottomConstraint;
}

- (NSLayoutConstraint *)keepLabelContainerHeightReasonableConstraint {
    return [NSLayoutConstraint constraintWithItem:self.labelContainerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300];
}

- (float)topMargin {
    return self.margin + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (UILabel *)contentLabel {
    UILabel* contentLabel = [[UILabel new] forAutolayout];
    contentLabel.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:10.f];
    [contentLabel setNumberOfLines:0];
    return contentLabel;
}

- (UILabel *)headerLabel {
    UILabel *headerLabel = [[UILabel new] forAutolayout];
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.f];
    return headerLabel;
}

- (void)imageScrollViewDidChangePresentedIndex:(SOZOImageScrollView *)imageScrollView {
    [self updateViewWithAlbumDataAtIndex:imageScrollView.visibleIndex];
}

- (void)updateViewWithAlbumDataAtIndex:(NSInteger)index {
    NSString *coverFilename = self.albumData[index][@"coverFilename"];
    UIImage *albumCoverImage = [UIImage imageNamed:coverFilename];
    SOZOChromoplast *chromoplast = [[SOZOChromoplast alloc] initWithImage:albumCoverImage];
    [self.swatchView setColors:chromoplast.colors];
    [self setLabelTextFromDictionary:self.albumData[index]];
    [UIView animateWithDuration:1.f animations:^{
        [self setColorsWithChromoplast:chromoplast];
        [self updateStatusBarColorWithChromoplast:chromoplast];
    }];
}

- (void)setLabelTextFromDictionary:(NSDictionary *)dictionary {
    self.titleLabel.text = dictionary[@"albumArtist"];
    self.header1.text = dictionary[@"albumTitle"];
    self.content1.text = [NSString stringWithFormat:@"Label: %@\nYear: %@\nDuration: %@", dictionary[@"label"], dictionary[@"releaseYear"], dictionary[@"duration"]];
    self.content2.text = dictionary[@"funFact"];
}

- (void)updateStatusBarColorWithChromoplast:(SOZOChromoplast *)chromoplast {
    [@"" isEqualToString:@""];
    if ([[UIColor whiteColor] sozo_isCompatibleWithColor:[chromoplast dominantColor]]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

- (void)setColorsWithChromoplast:(SOZOChromoplast *)chromoplast {
    self.imageScrollView.backgroundColor = chromoplast.firstHighlight;
    self.view.backgroundColor = chromoplast.dominantColor;
    self.titleLabel.textColor = chromoplast.secondHighlight;
    self.header1.numberOfLines = 2;
    self.header1.textColor = chromoplast.firstHighlight;
    self.content1.textColor = chromoplast.secondHighlight;
    self.header2.textColor = chromoplast.firstHighlight;
    self.content2.textColor = chromoplast.secondHighlight;
}

@end
