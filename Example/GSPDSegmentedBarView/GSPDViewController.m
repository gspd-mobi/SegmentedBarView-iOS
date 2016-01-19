//
//  GSPDViewController.m
//  GSPDSegmentedBarView
//
//  Created by Alexander Kiyaykin.
//  Copyright (c) 2016 GSPD. All rights reserved.
//

#import "GSPDViewController.h"
#import <GSPDSegmentedBarView/GSPDSegmentedBarView.h>
#import <CoreText/CoreText.h>

@interface GSPDViewController ()

@property (strong, nonatomic) IBOutlet GSPDSegmentedBarView *segmentedBarViewFromStoryboard;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation GSPDViewController {
    CGFloat yOffset;
    CGFloat barHeight;
    CGFloat topOffset;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    topOffset = 25.f;
    yOffset = 10.f;
    barHeight = 85.f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self customizeSegmentedBarViewFromStoryboard];
    
    NSMutableArray<GSPDSegmentedBarView *> *segmentedBarViews = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSInteger position = 0; position < 10; position++) {
        [segmentedBarViews addObject:[self segmentedBarViewInPosition:position]];
    }
    
    [self makeSegmentedBarViewNormal:segmentedBarViews[0]];
    [self makeSegmentedBarViewWithoutNumericValue:segmentedBarViews[1]];
    [self makeSegmentedBarViewWithMinValue:segmentedBarViews[2]];
    [self makeSegmentedBarViewWithMaxValue:segmentedBarViews[3]];
    [self makeSegmentedBarViewWithManySegments:segmentedBarViews[4]];
    [self makeSegmentedBarViewWithTwoSegments:segmentedBarViews[5]];
    [self makeSegmentedBarViewWithOneSegment:segmentedBarViews[6]];
    [self makeSegmentedBarViewWithNoSegments:segmentedBarViews[7]];
    [self makeSegmentedBarViewWithTwoSidedSideText:segmentedBarViews[8]];
    [self makeSegmentedBarViewWithoutValueSign:segmentedBarViews[9]];
    
    self.scrollView.contentSize = (CGSize){self.view.frame.size.width, segmentedBarViews[9].frame.origin.y + segmentedBarViews[9].frame.size.height};
}

- (void)customizeSegmentedBarViewFromStoryboard {
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"m2/s"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(1, 1)];
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    GSPDSegmentedBarSegment *segment3 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(2.1) maxValue:@(3.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment3.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    
    self.segmentedBarViewFromStoryboard.segments = @[segment1, segment2, segment3];
    self.segmentedBarViewFromStoryboard.value = @(1.1);
    self.segmentedBarViewFromStoryboard.unit = value;
}

- (void)makeSegmentedBarViewNormal:(GSPDSegmentedBarView *)segmentedBarView {
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"1012m/l"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(2, 2)];
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    segment2.segmentDescription = @"Segment 2";
    GSPDSegmentedBarSegment *segment3 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(2.1) maxValue:@(3.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment3.segmentDescription = @"Segment 3";
    segment3.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    
    segmentedBarView.segments = @[segment1, segment2, segment3];
    segmentedBarView.value = @(1.2);
    segmentedBarView.unit = value;
    
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithoutNumericValue:(GSPDSegmentedBarView *)segmentedBarView {
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.text = @"true";
    segment1.segmentDescription = @"Segment 1";
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    segment2.text = @"false";
    segment2.segmentDescription = @"Segment 2";
    
    segmentedBarView.segments = @[segment1, segment2];
    segmentedBarView.valueSegmentIndex = 0;
    
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithMinValue:(GSPDSegmentedBarView *)segmentedBarView {
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"1012m/l"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(2, 2)];
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    segment2.segmentDescription = @"Segment 2";
    GSPDSegmentedBarSegment *segment3 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(2.1) maxValue:@(3.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment3.segmentDescription = @"Segment 3";
    segment3.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    
    segmentedBarView.segments = @[segment1, segment2, segment3];
    segmentedBarView.value = @(0.1);
    segmentedBarView.unit = value;
    
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithMaxValue:(GSPDSegmentedBarView *)segmentedBarView {
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"1012m/l"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(2, 2)];
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    segment2.segmentDescription = @"Segment 2";
    GSPDSegmentedBarSegment *segment3 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(2.1) maxValue:@(3.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment3.segmentDescription = @"Segment 3";
    segment3.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    segment3.containsMaxValue = YES;
    
    segmentedBarView.segments = @[segment1, segment2, segment3];
    segmentedBarView.value = @(3.1);
    segmentedBarView.unit = value;
    
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithManySegments:(GSPDSegmentedBarView *)segmentedBarView {
    NSMutableArray<GSPDSegmentedBarSegment *> *segments = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i++) {
        UIColor *fillColor;
        if (i % 2 == 0) {
            fillColor = [UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1];
        } else {
            fillColor = [UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1];
        }
        GSPDSegmentedBarSegment *segment = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(i) maxValue:@(i + 1) color:fillColor];
        segment.segmentDescription = [NSString stringWithFormat:@"%ld", (long)i];
        [segments addObject:segment];
    }
    
    segmentedBarView.segments = segments;
    segmentedBarView.value = @(5.5);
    
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithTwoSegments:(GSPDSegmentedBarView *)segmentedBarView {
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"km2/s"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(2, 1)];
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    segment2.segmentDescription = @"Segment 2";
    segment2.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    
    
    segmentedBarView.segments = @[segment1, segment2];
    segmentedBarView.value = @(1.1);
    segmentedBarView.unit = value;
    
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithOneSegment:(GSPDSegmentedBarView *)segmentedBarView {
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"km2/s"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(2, 1)];
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.5) maxValue:@(9.5) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleTwoSided;
    
    
    segmentedBarView.segments = @[segment1];
    segmentedBarView.value = @(3.29);
    segmentedBarView.unit = value;
    
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithNoSegments:(GSPDSegmentedBarView *)segmentedBarView {
    segmentedBarView.value = @(0);
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithTwoSidedSideText:(GSPDSegmentedBarView *)segmentedBarView {
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:@"1012m/l"
                                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                                                                           NSBackgroundColorAttributeName : [UIColor clearColor],
                                                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSDictionary *superscriptAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                            NSBackgroundColorAttributeName : [UIColor clearColor],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            (NSString *)kCTSuperscriptAttributeName : @(1)};
    [value setAttributes:superscriptAttributes range:NSMakeRange(2, 2)];
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    segment2.segmentDescription = @"Segment 2";
    GSPDSegmentedBarSegment *segment3 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(2.1) maxValue:@(3.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment3.segmentDescription = @"Segment 3";
    
    segmentedBarView.segments = @[segment1, segment2, segment3];
    segmentedBarView.value = @(1.2);
    segmentedBarView.unit = value;
    
    [self.scrollView addSubview:segmentedBarView];
}

- (void)makeSegmentedBarViewWithoutValueSign:(GSPDSegmentedBarView *)segmentedBarView {
    
    GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    segment2.segmentDescription = @"Segment 2";
    GSPDSegmentedBarSegment *segment3 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(2.1) maxValue:@(3.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment3.segmentDescription = @"Segment 3";
    segment3.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    
    segmentedBarView.segments = @[segment1, segment2, segment3];
    
    [self.scrollView addSubview:segmentedBarView];
}

- (GSPDSegmentedBarView *)segmentedBarViewInPosition:(NSInteger)position {
    GSPDSegmentedBarView *segmentedBarView = [[GSPDSegmentedBarView alloc] initWithFrame:(CGRect){{0, [self topOffsetForPosition:position]}, {self.view.frame.size.width, barHeight}}];
    return segmentedBarView;
}

- (CGFloat)topOffsetForPosition:(NSInteger)position {
    return topOffset + barHeight + position * (yOffset + barHeight);
}

@end
