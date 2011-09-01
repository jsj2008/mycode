//
//  CanvasObjectBackground.h
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CanvasObject.h"

@interface CanvasObjectBackground : CanvasObject {
    UIImageView *background;
}
@property(nonatomic,retain)  UIImageView *background;
@end
