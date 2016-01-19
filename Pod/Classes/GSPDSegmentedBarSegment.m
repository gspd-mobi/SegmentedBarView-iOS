#import "GSPDSegmentedBarSegment.h"

@implementation GSPDSegmentedBarSegment

- (instancetype)initWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue color:(UIColor *)color {
    return [self initWithMinValue:minValue maxValue:maxValue color:color description:nil customText:nil];
}

- (instancetype)initWithMinValue:(NSNumber *)minValue maxValue:(NSNumber *)maxValue color:(UIColor *)color description:(NSString *)description customText:(NSString *)text {
    self = [super init];
    if (self) {
        self.minValue = minValue;
        self.maxValue = maxValue;
        self.color = color;
        self.segmentDescription = description;
        self.text = text;
        self.containsMinValue = YES;
        self.containsMaxValue = NO;
    }
    return self;
}

- (BOOL)isPoint {
    return [self.minValue isEqualToNumber:self.maxValue];
}

@end
