﻿//================================================================================
//
// (c) Copyright China Digital Video (Beijing) Limited, 2021. All rights reserved.
//
// This code and information is provided "as is" without warranty of any kind,
// either expressed or implied, including but not limited to the implied
// warranties of merchantability and/or fitness for a particular purpose.
//
//--------------------------------------------------------------------------------
//   Birth Date:    Mar 25. 2021
//   Author:        NewAuto video team
//================================================================================

#pragma once

#import <Foundation/Foundation.h>
#import "NvsCommonDef.h"

/*! \if ENGLISH
*   \brief Key frame control point pair structure.
*   \else
*   \brief 关键帧控制点对类。
*   \endif
*/

NVS_EXPORT @interface NvsControlPointPair : NSObject

@property (nonatomic, assign) NvsPointD backwardControlPoint;
@property (nonatomic, assign) NvsPointD forwardControlPoint;

@end
