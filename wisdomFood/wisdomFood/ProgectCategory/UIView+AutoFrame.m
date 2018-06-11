//
//  UIView+AutoFrame.m
//  wisdomfood
//
//  Created by 赵小波 on 2018/5/30.
//  Copyright © 2018年 sanfangyuan. All rights reserved.
//

#import "UIView+AutoFrame.h"

@implementation UIView (AutoFrame)

-(CGFloat)get_x{
    
    return  self.frame.origin.x;
}
-(void)setGet_x:(CGFloat)get_x{
    
    CGRect  frame=self.frame;
    
    frame.origin.x=get_x;
    
    self.frame=frame;
}
-(CGFloat)get_y{
    
    return  self.frame.origin.y;
}
-(void)setGet_y:(CGFloat)get_y{
    
    CGRect  frame=self.frame;
    
    frame.origin.y=get_y;
    
    self.frame=frame;
}
-(CGFloat)get_right{
    
    return self.frame.origin.x+self.frame.size.width;
}
-(void)setGet_right:(CGFloat)get_right{
    
    
    CGRect frame=self.frame;
    
    frame.origin.x=get_right-frame.size.width;
    
    self.frame=frame;
}

-(CGFloat)get_bottom{
    
    return self.frame.origin.y+self.frame.size.height;
}
-(void)setGet_bottom:(CGFloat)get_bottom{
    
    CGRect  frame=self.frame;
    
    frame.origin.y=get_bottom-frame.size.height;
    
    self.frame=frame;
    
}
-(CGFloat)get_width{
    
    
    return self.frame.size.width;
}
-(void)setGet_width:(CGFloat)get_width{
    
    CGRect  frame=self.frame;
    
    frame.size.width=get_width;
    
    self.frame=frame;
    
}
-(CGFloat)get_height{
    
    return  self.frame.size.height;
}
-(void)setGet_height:(CGFloat)get_height{
    
    CGRect  frame=self.frame;
    
    frame.size.height=get_height;
    
    self.frame=frame;
}
-(CGFloat)get_centerX{
    
    return  self.center.x;
}
-(void)setGet_centerX:(CGFloat)get_centerX{
    
    self.center=CGPointMake(get_centerX,self.center.y);
    
}
-(CGPoint)get_origin{
    
   return  self.frame.origin;
}
-(void)setGet_origin:(CGPoint)get_origin{
    
    
    CGRect frame=self.frame;
    
    frame.origin=get_origin;
    
    self.frame=frame;
    
}
-(CGSize)get_size{
    
    
    return self.frame.size;
}
-(void)setGet_size:(CGSize)get_size
{
    
    CGRect  frame=self.frame;
    
    frame.size=get_size;
    
    self.frame=frame;
}
@end
