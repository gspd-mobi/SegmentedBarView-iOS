# GSPDSegmentedBarView

[![Version](https://img.shields.io/cocoapods/v/GSPDSegmentedBarView.svg?style=flat)](http://cocoapods.org/pods/GSPDSegmentedBarView)
[![License](https://img.shields.io/cocoapods/l/GSPDSegmentedBarView.svg?style=flat)](http://cocoapods.org/pods/GSPDSegmentedBarView)
[![Platform](https://img.shields.io/cocoapods/p/GSPDSegmentedBarView.svg?style=flat)](http://cocoapods.org/pods/GSPDSegmentedBarView)

## Screenshots

![Imgur](http://i.imgur.com/jlAMdNL.png)
![Imgur](http://i.imgur.com/AwP8qn4.png)

## Usage

#### Constructor and setters ####

```objective-c
GSPDSegmentedBarView *segmentedBarView = [[GSPDSegmentedBarView alloc] init];
segmentedBarView.unit = attributedUnit;
segmentedBarView.segments = segmentedBarViewSegments;
segmentedBarView.value = value;
```

```objective-c
GSPDSegmentedBarView *segmentedBarView = [[GSPDSegmentedBarView alloc] initWithValue:@(1.0) unit:nil segments:segments];
```

Also you can use it with xibs and storyboards.

#### Create segments ####

In any case you should create segments list to put in view.
```objective-c
GSPDSegmentedBarSegment *segment1 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(0.1) maxValue:@(1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment1.segmentDescription = @"Segment 1";
    segment1.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    GSPDSegmentedBarSegment *segment2 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(1.1) maxValue:@(2.1) color:[UIColor colorWithRed:0.55 green:0.78 blue:0.24 alpha:1]];
    segment2.segmentDescription = @"Segment 2";
    GSPDSegmentedBarSegment *segment3 = [[GSPDSegmentedBarSegment alloc] initWithMinValue:@(2.1) maxValue:@(3.1) color:[UIColor colorWithRed:0.94 green:0.24 blue:0.18 alpha:1]];
    segment3.segmentDescription = @"Segment 3";
    segment3.sideTextStyle = GSPDSegmentedBarSegmentSideTextStyleOneSided;
    
segmentedBarView.segments = @[segment1, segment2, segment3];
```

Each segment contains min and max value, color, description text (optional), custom text (optional). Value sign position is calculated automatically in these intervals.

Also there can be segments with no min and max. Then you should set valueSegmentIndex field of SegmentedBarView, it's just an index of segment to show value sign over.

## Installation

GSPDSegmentedBarView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GSPDSegmentedBarView"
```

## Author

Alexander Kiyaykin, GSPD, alexander.kiyaykin@gspd.mobi

## License

GSPDSegmentedBarView is available under the MIT license. See the LICENSE file for more info.
