//================================================================================
//
// (c) Copyright China Digital Video (Beijing) Limited, 2017. All rights reserved.
//
// This code and information is provided "as is" without warranty of any kind,
// either expressed or implied, including but not limited to the implied
// warranties of merchantability and/or fitness for a particular purpose.
//
//--------------------------------------------------------------------------------
//   Birth Date:    Feb 17. 2017
//   Author:        NewAuto video team
//================================================================================
#pragma once

#import "NvsFx.h"
#import "NvsAnimatedSticker.h"
#import <CoreGraphics/CGGeometry.h>

/*! \if ENGLISH
 *  \brief Track animated sticker class.
 *
 *  Track animation sticker is a landscaping effect used in video editing to produce animated effects.
 * Users can add and remove animated stickers from the track, as well as adjust various properties of the stickers through various APIs, such as position, size, display time, and so on.
 *  <br>Note: The in-point and out-point units of the animated sticker on the Track are both in microseconds.
 *  \warning In the NvsTrackAnimatedSticker class, all public APIs are used in the UI thread! ! !
 *  \else
 *  \brief 轨道动画贴纸类
 *
 *  轨道动画贴纸是视频编辑时使用的一种美化特效，可以产生动画效果。
 *  用户可以在轨道上添加和移除动画贴纸，也可以通过各种API调整贴纸的各种属性，如位置、大小、显示时间等等。
 *  <br>注：动画贴纸在轨道上的入点和出点单位都为微秒
 *  \warning NvsTrackAnimatedSticker API都在UI线程使用！！！
 *  \endif
 *  \since 2.20.0
 */
NVS_EXPORT @interface NvsTrackAnimatedSticker : NvsAnimatedSticker

@property (nonatomic) BOOL clipAffinityEnabled; //!< \if ENGLISH Whether to turn on the affinity with clip.If it is turned on, the operation of the clip will affect the sticker. Default mode is on. \else 是否开启与clip的亲和关系，如果开启则对片段的操作会影响贴纸。默认为开启 \endif \since 1.7.1
@property (readonly) int64_t inPoint;           //!< \if ENGLISH The in point of the animated sticker on the track (in microseconds). \else 动画贴纸在轨道显示的入点（单位微秒） \endif
@property (readonly) int64_t outPoint;          //!< \if ENGLISH The out point of the animated sticker on the track (in microseconds). \else 动画贴纸在轨道上显示的出点（单位微秒） \endif


/*! \if ENGLISH
 *  \brief Change the in-point of the animated sticker on the track.
 *  When the new in-point does not conform to the established rules, the final return in-point may be different from the new in-point value.
 *  Such as the new in-point is less than 0, the new in-point value is greater than the timeline duration, or the new in-point is greater than the out-point.
 *  \param newInPoint The new in-point of the animated sticker on the track (in microseconds).
 *  \return Return the in-point of the animated sticker on the track (in microseconds).
 *  \warning This interface will cause the streaming engine state to jump to the engine stop state. For details, please refer to [Engine Change](\ref EngineChange.md).
 *  \else
 *  \brief 改变动画贴纸在轨道上显示的入点
 *  当设置的入点值不符合既定规则时最终返回入点值有可能与设置的入点值不同，比如新的入点值小于0，新的入点值大于轨道长度或者新的入点值大于出点值。
 *  \param newInPoint 动画贴纸在轨道上的新入点（单位微秒）
 *  \return 返回动画贴纸在轨道上显示的入点（单位微秒）
 *  \warning 此接口会引发流媒体引擎状态跳转到引擎停止状态，具体情况请参见[引擎变化专题] (\ref EngineChange.md)
 *  \endif
 *  \sa changeOutPoint
 *  \sa getInPoint
 *  \sa movePosition
 */
- (int64_t)changeInPoint:(int64_t)newInPoint;

/*! \if ENGLISH
 *  \brief Change the out-point of the animated sticker on the track.
 *  When the new out-point does not conform to the established rules, the final return out-point may be different from the new out-point value.
 *  Such as the new out-point is less than 0, the new out-point value is greater than the timeline duration, or the new out-point is less than the in-point.
 *  \param newOutPoint The out-point of the animated sticker on the track (in microseconds).
 *  \return Return the out-point of the animated sticker on the track (in microseconds).
 *  \warning This interface will cause the streaming engine state to jump to the engine stop state. For details, please refer to [Engine Change] (\ref EngineChange.md).
 *  \else
 *  \brief 改变动画贴纸在轨道上显示的出点
 *  当设置的出点值不符合既定规则时最终返回出点值有可能与设置的出点值不同，比如新的出点值小于0，新的出点值大于轨道长度或者新的出点值小于入点值。
 *  \param newOutPoint 动画贴纸在轨道上的新的出点（单位微秒）
 *  \return 返回动画贴纸在轨道上的显示的出点（单位微秒）
 *  \warning 此接口会引发流媒体引擎状态跳转到引擎停止状态，具体情况请参见[引擎变化专题] (\ref EngineChange.md)
 *  \endif
 *  \sa changeInPoint
 *  \sa getOutPoint
 *  \sa movePosition
 */
- (int64_t)changeOutPoint:(int64_t)newOutPoint;

/*! \if ENGLISH
 *  \brief Change the display position of the animated sticker on the track (the in and out points are offset from the offset value at the same time).
 *  \param offset Offset value for in and out points changes (in microseconds).
 *  \warning This interface will cause the streaming engine state to jump to the engine stop state. For details, please refer to [Engine Change](\ref EngineChange.md).
 *  \else
 *  \brief 改变动画贴纸在轨道上的显示位置(入点和出点同时偏移offset值)
 *  \param offset 入点和出点改变的偏移值（单位微秒）
 *  \warning 此接口会引发流媒体引擎状态跳转到引擎停止状态，具体情况请参见[引擎变化专题] (\ref EngineChange.md)
 *  \endif
 *  \sa changeInPoint
 *  \sa changeOutPoint
 */
- (void)movePosition:(int64_t)offset;

@end

