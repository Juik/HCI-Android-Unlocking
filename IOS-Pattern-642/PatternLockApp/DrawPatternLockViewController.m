//
//  ViewController.m
//  AndroidLock
//
//  Created by Purnama Santo on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DrawPatternLockViewController.h"
#import "DrawPatternLockView.h"
extern NSDate *unlockStart;
extern NSDate *unlockFinish;
extern NSTimeInterval executionTime;
extern NSArray *patternDictionary;
extern int counter;
extern int currentIdx;
#define MATRIX_SIZE 3
//#define TICK   NSDate *startTime = [NSDate date]
//#define TOCK NSLog(@"%s Time: %f", __func__, -[startTime timeIntervalSinceNow])

@implementation DrawPatternLockViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView {
  [super loadView];
  
  self.view = [[DrawPatternLockView alloc] init];
}

// random number generator
-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

- (void)viewDidLoad
{
  [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   


   for(int i=0;i<6;i++)
   {
        NSString *temp = [NSString stringWithFormat: @"%i.png", (1+i)];
        UIImage *dotImage = [UIImage imageNamed:temp];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:dotImage
                                                   highlightedImage:[UIImage imageNamed:@"dot_on1.png"]];
        imageView.frame = CGRectMake(0, 0, dotImage.size.width/1.3, dotImage.size.height/1.3);
        imageView.userInteractionEnabled = YES;
        imageView.tag = i+1;
        [self.view addSubview:imageView];
    }
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.textColor = [UIColor blueColor];
    textField.textAlignment = UITextAlignmentCenter;

    currentIdx = [self getRandomNumberBetween:0 to: 19];
    
    NSString *tempStr = patternDictionary[currentIdx];
    NSString *finalStr = [NSString stringWithFormat: @"Pattern<%@", tempStr];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"0" withString:@"-"];
    
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"1" withString:@"f"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"2" withString:@"h"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"3" withString:@"s"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"4" withString:@"b"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"5" withString:@"c"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"6" withString:@"d"];
    
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"f" withString:@"6"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"h" withString:@"1"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"s" withString:@"5"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"b" withString:@"2"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"c" withString:@"4"];
    finalStr = [finalStr stringByReplacingOccurrencesOfString:@"d" withString:@"3"];
    textField.placeholder = finalStr;
    textField.delegate = self;
    
    
    [self.view addSubview:textField];
    

//  for (int i=0; i<2; i++)
//  {
//    for (int j=0; j<3; j++)
//    {
//      UIImage *dotImage = [UIImage imageNamed:@"dot_off.png"];
//      UIImageView *imageView = [[UIImageView alloc] initWithImage:dotImage
//                                                 highlightedImage:[UIImage imageNamed:@"dot_on.png"]];
//      imageView.frame = CGRectMake(0, 0, dotImage.size.width/2, dotImage.size.height/2);
//      imageView.userInteractionEnabled = YES;
//      imageView.tag = j + i*3 + 1;
//      [self.view addSubview:imageView];
//    }
//  }
}


- (void)viewWillLayoutSubviews {
//  int w = 100/MATRIX_SIZE;
//  int h = 100/MATRIX_SIZE;
    int x=55;//move right
    int y=165;//move down
    int diameter = 150;
    int radius = diameter / 2;
    int longSide = 1.73205/2*radius;
    int shortSide = radius/2;

  int i=0;
  for (UIView *view in self.view.subviews)
  {
    if ([view isKindOfClass:[UIImageView class]])
    {
//      int x = w*(i/MATRIX_SIZE) + w/2;
//      int y = h*(i%MATRIX_SIZE) + h/2;
        if(i==0){
            view.center = CGPointMake(shortSide+x+35, 0+y+35);
            i++;
        }
        else if(i==1){
            view.center = CGPointMake(radius+shortSide+x+35, 0+y+35);
            i++;
        }
        else if(i==2){
            view.center = CGPointMake(0+x+35, longSide+y+35);
            i++;
        }
        else if(i==3){
            view.center = CGPointMake(diameter+x+35, longSide+y+35);
            i++;
        }
        else if(i==4){
            view.center = CGPointMake(shortSide+x+35, 2*longSide+y+35);
            i++;
        }
        else if(i==5){
            view.center = CGPointMake(radius+shortSide+x+35, 2*longSide+y+35);
            i++;
        }
        else
            continue;
    }
  }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    unlockStart = [NSDate date];
  _paths = [[NSMutableArray alloc] init];
}



- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint pt = [[touches anyObject] locationInView:self.view];
  UIView *touched = [self.view hitTest:pt withEvent:event];
  
  DrawPatternLockView *v = (DrawPatternLockView*)self.view;
  [v drawLineFromLastDotTo:pt];

  if (touched!=self.view) {
    NSLog(@"touched view tag: %d ", touched.tag);
    
    BOOL found = NO;
    for (NSNumber *tag in _paths) {
      found = tag.integerValue==touched.tag;
      if (found)
        break;
    }
    
    if (found)
      return;

    [_paths addObject:[NSNumber numberWithInt:touched.tag]];
    [v addDotView:touched];

    UIImageView* iv = (UIImageView*)touched;
    iv.highlighted = YES;
  }

}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  // clear up hilite
  DrawPatternLockView *v = (DrawPatternLockView*)self.view;
  [v clearDotViews];

  for (UIView *view in self.view.subviews)
    if ([view isKindOfClass:[UIImageView class]])
      [(UIImageView*)view setHighlighted:NO];
  
  [self.view setNeedsDisplay];
  
  // pass the output to target action...
  if (_target && _action)
    [_target performSelector:_action withObject:[self getKey]];

}


// get key from the pattern drawn
// replace this method with your own key-generation algorithm
- (NSString*)getKey {
    NSMutableString *key;
    key = [NSMutableString string];
    
    // simple way to generate a key
    for (NSNumber *tag in _paths)
    {
        [key appendFormat:@"%02d", tag.integerValue];
    }
    
    // save the execution time
    unlockFinish = [NSDate date];
    executionTime = [unlockFinish timeIntervalSinceDate:unlockStart];

    return key;
}



- (void)setTarget:(id)target withAction:(SEL)action {
  _target = target;
  _action = action;
}

@end
