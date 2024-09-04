﻿//================================================================================
//
// (c) Copyright China Digital Video (Beijing) Limited, 2017. All rights reserved.
//
// This code and information is provided "as is" without warranty of any kind,
// either expressed or implied, including but not limited to the implied
// warranties of merchantability and/or fitness for a particular purpose.
//
//--------------------------------------------------------------------------------
//   Birth Date:    Feb 16. 2017
//   Author:        NewAuto video team
//================================================================================
#pragma once

#import "NvsFx.h"
#import "NvsCaption.h"
#import <CoreGraphics/CGGeometry.h>

/*! \if ENGLISH
 *  \brief Timeline captions
 *
 *  Timeline captions are the custom text that is superimposed on the video. When editing a video, users can add and remove the timeline captions and adjust the caption position. After adding subtitles, user can also set the style, including font size, color, shadow, stroke, etc.
 *  \warning In the NvsTimelineCaption class, all public APIs are used in the UI thread! ! !
 *  \else
 *  \brief 时间线字幕
 *
 *  时间线字幕是视频上叠加的自定义文字。编辑视频时，可以添加和移除时间线字幕，并对字幕位置进行调整处理。添加完字幕，还可以进行样式设置，包括字体大小，颜色，阴影，描边等。
 *  \warning NvsTimelineCaption类中，所有public API都在UI线程使用！！！
 *  \endif
*/
NVS_EXPORT @interface NvsTimelineCaption : NvsCaption

@property (nonatomic) BOOL clipAffinityEnabled;       //!< \if ENGLISH Whether to enable the affinity with clip \else 是否开启与clip的亲和关系 \endif \since 1.7.1
@property (readonly) int64_t inPoint;                 //!< \if ENGLISH The in point of the caption on the timeline(in microseconds) \else 字幕在时间线上显示的入点（单位微秒） \endif
@property (readonly) int64_t outPoint;                //!< \if ENGLISH The out point of the caption on the timeline (in microseconds) \else 字幕在时间线显示上的出点（单位微秒） \endif

/*! \if ENGLISH
 *  \brief Changes the out point of the caption on the timeline.
 *  \param newInPoint The new out point of the caption on the timeline (in microseconds)
 *  \return Returns the in point of the caption which displayed on the timeline (in microseconds).
 *  \warning This interface will cause the streaming engine state to jump to the state of stopping engine. For details, please refer to [The Topic of Changing Engine](\ref EngineChange.md).
 *  \else
 *  \brief 改变字幕在时间线上显示的入点
 *  \param newInPoint 字幕在时间线上的新的入点（单位微秒）
 *  \return 返回字幕在时间线上的显示的入点值（单位微秒）
 *  \warning 此接口会引发流媒体引擎状态跳转到引擎停止状态，具体情况请参见[引擎变化专题] (\ref EngineChange.md)。
 *  \endif
 *  \sa changeOutPoint:
 *  \sa movePosition:
*/
- (int64_t)changeInPoint:(int64_t)newInPoint;

/*! \if ENGLISH
 *  \brief Changes the out point of the caption on the timeline.
 *  \param newOutPoint The new out point of the caption on the timeline (in microseconds)
 *  \return Returns the out point of the caption which displayed on the timeline (in microseconds).
 *  \warning This interface will cause the streaming engine state to jump to the state of stopping engine. For details, please refer to [The Topic of Changing Engine](\ref EngineChange.md).
 *  \else
 *  \brief 改变字幕在时间线上显示的出点
 *  \param newOutPoint 字幕在时间线上的新的出点（单位微秒）
 *  \return 返回字幕在时间线上显示的出点值（单位微秒）
 *  \warning 此接口会引发流媒体引擎状态跳转到引擎停止状态，具体情况请参见[引擎变化专题] (\ref EngineChange.md)。
 *  \endif
 *  \sa changeInPoint:
 *  \sa movePosition:
*/
- (int64_t)changeOutPoint:(int64_t)newOutPoint;

/*! \if ENGLISH
 *  \brief Changes the display position of the caption on the timeline (the in and out points move the value of "offset" at the same time).
 *  \param offset The offset value (in microseconds)
 *  \warning This interface will cause the streaming engine state to jump to the state of stopping engine. For details, please refer to [The Topic of Changing Engine](\ref EngineChange.md).
 *  \else
 *  \brief 改变字幕在时间线上的显示位置(入点和出点同时偏移offset值)
 *  \param offset 偏移值（单位微秒）
 *  \warning 此接口会引发流媒体引擎状态跳转到引擎停止状态，具体情况请参见[引擎变化专题] (\ref EngineChange.md)。
 *  \endif
 *  \sa changeInPoint:
 *  \sa changeOutPoint:
*/
- (void)movePosition:(int64_t)offset;

@end

