import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nvshortvideo/nvshortvideo.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:nvshortvideodemo/generated/l10n.dart';
import 'video_player_page.dart';

class VideoEditResultPage extends StatefulWidget {
  final Map arguments;

  const VideoEditResultPage(
      {super.key, required this.arguments, required this.title});

  final String title;

  @override
  VideoEditResultPageState createState() => VideoEditResultPageState();
}

class VideoEditResultPageState extends State<VideoEditResultPage> {
  VideoEditResultPageState();

  String draftInfo = "";
  String editProjectId = "";
  String? localVideoPath;
  bool hasDraft = false;
  bool saveVideoAndPop = false;
  bool isFirstBuild = true;
  PopupHUD? _popup;

  PopupHUD get popup {
    _popup ??= PopupHUD(
      context,
      hud: HUD(
        label: '',
        detailLabel: '',
      ),
    );
    return _popup!;
  }

  @override
  void initState() {
    super.initState();
    draftInfo = widget.arguments["draftInfo"] ?? "";
    hasDraft = widget.arguments["hasDraft"] ?? false;
    editProjectId = widget.arguments["projectId"] ?? "";
    localVideoPath = widget.arguments["videoPath"];
    if (localVideoPath != null) {
      isFirstBuild = false;
    }
    shortVideoOperator()
        .setVideoCompileEventHandler((event, compileInfo) async {
      if (event == NvVideoCompileEvent.progress) {
        double progress = compileInfo["progress"];
        popup.setValue(progress / 100);
        popup.setLabel('${(progress).toInt()}%');
        popup.setDetailLabel("");
      } else if (event == NvVideoCompileEvent.complete) {
        String? outputPath = compileInfo["outputPath"];
        debugPrint("compile outputPath:$outputPath");
        if (outputPath == null) {
          int errorCode = compileInfo["errorCode"];
          String? errorString = compileInfo["errorString"];
          if (errorCode == -2) {
            popup.setLabel(S.of(context).compile_cancel);
            popup.setDetailLabel("");
          } else {
            popup.setLabel(S.of(context).compile_fail);
            popup.setDetailLabel(errorString ?? "");
          }
        } else {
          popup.setLabel(saveVideoAndPop
              ? S.of(context).save_suc
              : S.of(context).compile_suc);
          popup.setDetailLabel("");
          localVideoPath = outputPath;
          debugPrint("compile localVideoPath:$localVideoPath");
        }
        await Future.delayed(const Duration(milliseconds: 500));
        dismissPopup();
        if (isFirstBuild) isFirstBuild = false;
        setState(() {});
        if (saveVideoAndPop && outputPath != null) Navigator.of(context).pop();
      } else if (event == NvVideoCompileEvent.coverImageSelected) {
        debugPrint("setSaveImageEventHandler:$compileInfo");
        String coverImagePath = compileInfo["coverImagePath"];
        if (coverImagePath.isNotEmpty) {
          widget.arguments["coverImagePath"] = coverImagePath;
          setState(() {});
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstBuild) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        saveVideoAndPop = false;
        saveVideo();
      });
    }
  }

  void dismissPopup() {
    if (_popup != null) {
      _popup!.dismiss();
      _popup = null; // 在 dismiss 后将 _popup 置为 null
    }
  }

  void saveImage() async {
    String info = widget.arguments["coverImagePath"];
    debugPrint("coverImagePath:$info");
    var result = await shortVideoOperator().saveImage(info);
    debugPrint("coverImagePath:$result");
    popup.setLabel(S.of(context).save_suc);
    if (result != null) {
      var error = result["error"];
      if (error != null) {
        popup.setLabel(S.of(context).save_failed);
      }
    }
    popup.show();

    Future.delayed(const Duration(seconds: 1), () {
      popup.dismiss();
    });
  }

  void saveVideo() async {
    popup.setValue(0);
    popup.setLabel(S.of(context).Generating);
    popup.setDetailLabel('');
    popup.show();
    shortVideoOperator().compileCurrentTimeline({});
  }

  @override
  void dispose() {
    super.dispose();
    // 取消监听视频合成事件 / cancel listening to video compilation events
    shortVideoOperator().setVideoCompileEventHandler(null);
    //退出编辑流程
    //Exit the editing process
    shortVideoOperator().exitEdit(editProjectId);
  }

  void saveDraft() async {
    debugPrint("saveDraft *** ");
    shortVideoOperator().saveDraft(draftInfo);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          color: Colors.white, // 标题文本颜色
          fontSize: 16.5, // 标题文本字体大小
          fontWeight: FontWeight.bold, // 标题文本字体粗细
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          //触摸收起键盘
          //Touch to close the keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
              child: Row(
                children: [
                  LimitedBox(
                    maxWidth: 270,
                    maxHeight: 120,
                    child: TextField(
                      controller: TextEditingController(text: draftInfo),
                      autocorrect: false,
                      autofocus: false,
                      maxLines: 100,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: S.of(context).text_placeholder,
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(128, 128, 128, 1),
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.only(left: 10, top: 10, right: 10),
                      ),
                      onChanged: (val) {
                        draftInfo = val;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7.5),
                      child: Stack(
                        children: [
                          Image.file(
                            File(widget.arguments["coverImagePath"]),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 110,
                          ),
                          Visibility(
                            visible:
                                localVideoPath == null && isFirstBuild == false,
                            child: Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(60, 30),
                                    maximumSize: const Size(60, 30),
                                    backgroundColor:
                                        const Color.fromRGBO(47, 47, 47, 0.7),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                  ),
                                  onPressed: () {
                                    debugPrint('retry!');
                                    saveVideoAndPop = false;
                                    saveVideo();
                                  },
                                  child: Text(
                                    S.of(context).TryAgin,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    // textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: localVideoPath != null,
                            child: Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    debugPrint('Image clicked!');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoPlayerPage(
                                            videoPath: localVideoPath!),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    "assets/images/video_play@2x.png",
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: localVideoPath != null,
                            child: Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  debugPrint('Image clicked!');
                                  shortVideoOperator().selectCoverImage();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                  color: Colors.black.withOpacity(0.7),
                                  child: Text(
                                    S.of(context).Select_Cover,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: hasDraft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 45),
                          backgroundColor: const Color.fromRGBO(47, 47, 47, 1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          //触摸收起键盘
                          //Touch to close the keyboard
                          FocusScope.of(context).requestFocus(FocusNode());
                          saveDraft();
                        },
                        child: Text(
                          S.of(context).save_draft,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 45),
                        backgroundColor: const Color.fromRGBO(252, 62, 90, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        alignment: Alignment.center,
                      ),
                      onPressed: () async {
                        // 触摸收起键盘
                        FocusScope.of(context).requestFocus(FocusNode());
                        saveImage();
                      },
                      child: Text(
                        S.of(context).Save_Image,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 45),
                        backgroundColor: const Color.fromRGBO(252, 62, 90, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        alignment: Alignment.center,
                      ),
                      onPressed: () async {
                        // 触摸收起键盘
                        FocusScope.of(context).requestFocus(FocusNode());
                        saveVideoAndPop = true;
                        saveVideo();
                      },
                      child: Text(
                        S.of(context).Export,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
