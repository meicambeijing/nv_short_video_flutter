// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'darft_list.dart';
import 'homePageFunctionButton.dart';
import 'video_edit_result.dart';
import 'package:nvshortvideo/nvshortvideo.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Map<String, dynamic>> dataSource;
  NvVideoConfig videoConfig = NvVideoConfig();
  @override
  void initState() {
    super.initState();

    //服务器地址
    //Server url
    /// assetRequestUrl  素材列表请求 Material list request
    /// assetCategoryUrl 素材分类列表请求 Material category list request
    /// assetMusiciansUrl 音乐列表请求 Music list request
    /// assetFontUrl 字体列表请求 Font list request
    /// assetDownloadUrl 下载地址请求 Download address request
    /// assetPrefabricatedUrl 预制素材请求 Prefabricated material request
    /// assetAutoCutUrl 一键成片网络请求 AutoCut request
    /// assetTagUrl 模版标签列表请求 Template tag list request
    /// clientId clientId
    /// clientSecret clientSecret
    /// assemblyId assemblyId
    /// isAbroad 海外数据请求，0==全部，1==海外 Overseas data request, 0== all, 1== overseas
    Map<String, dynamic> map = {
      'host': 'https://mall.meishesdk.com/api/shortvideo/test/',
      'assetRequestUrl': 'materialcenter/mall/custom/listAllAssemblyMaterial',
      'assetCategoryUrl': 'materialcenter/appSdkApi/listTypeAndCategory',
      'assetMusiciansUrl': 'materialcenter/appSdkApi/listMusic',
      'assetFontUrl': 'materialcenter/listFont',
      'assetDownloadUrl': 'materialcenter/mall/custom/materialInteraction',
      'assetPrefabricatedUrl': 'materialcenter/beautyAssets/latest',
      'assetAutoCutUrl': 'materialcenter/recommend/listTemplate',
      'assetTagUrl': 'materialcenter/listTemplateTag',
      'clientId': '7480f2bf193d417ea7d93d64',
      'clientSecret': 'e4434ff769404f64b33f462331a80957',
      'assemblyId': 'MEISHE_MATERIAL_LIST',
      'isAbroad': 1
    };

    shortVideoOperator().configServerInfo(map);

    shortVideoOperator().setVideoEditEventHandler((event, info) {
      if (event == NvVideoEditEvent.publish) {
        //注册跳转到发布页回调
        //Register to jump to the release page callback
        var resultPage =
            VideoEditResultPage(title: S.of(context).Publish, arguments: info);
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return resultPage;
            },
          ),
        );
      }
    });
    fetchTestJsonFile();
  }

  fetchTestJsonFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final testDir = "${dir.path}/Config";
    final testDirfile = Directory(testDir);
    if (!testDirfile.existsSync()) {
      testDirfile.createSync(recursive: true);
      // fillTestTheme();
    } else {
      final path = "$testDir/test.json";
      final file = File(path);
      if (file.existsSync()) {
        final fileContent = file.readAsStringSync();
        Map<String, dynamic> jsonData = jsonDecode(fileContent);
        videoConfig = NvVideoConfig.jsonDecode(jsonData);
        debugPrint("load test json:$path");
      } else {
        debugPrint("test json file not exist");
        // fillTestTheme();
      }
    }
  }

  fillTestTheme() {
    videoConfig.primaryColor = "#0000FF";
    videoConfig.backgroundColor = "#00FA9A";
    videoConfig.panelBackgroundColor = "#000080";
    videoConfig.textColor = "#FFA500";
    videoConfig.secondaryTextColor = "#8A2BE2";
    videoConfig.enableLocalMusic = false;

    //相册配置 albumConfig
    videoConfig.albumConfig.type = 1;
    videoConfig.albumConfig.maxSelectCount = 5;
    videoConfig.albumConfig.useAutoCut = false;

    //拍摄配置 captureConfig
    videoConfig.captureConfig.captureMenuItems = [
      NvCaptureMenuItem.device,
      NvCaptureMenuItem.speed,
      NvCaptureMenuItem.beauty,
      NvCaptureMenuItem.original,
      NvCaptureMenuItem.filter
    ];
    videoConfig.captureConfig.captureBottomMenuItems = [
      NvCaptureBottomMenuItem.image,
      NvCaptureBottomMenuItem.video
    ];
    videoConfig.captureConfig.captureDeviceIndex = 0;
    videoConfig.captureConfig.resolution =
        NvVideoPreviewResolution.NvVideoPreviewResolution_720;
    videoConfig.captureConfig.ignoreVideoRotation = false;
    videoConfig.captureConfig.imageDuration = 6 * 1000;
    videoConfig.captureConfig.autoSavePhotograph = true;
    var pair1 = NvTimePair(1 * 1000, 10 * 1000);
    var pair2 = NvTimePair(0, 50 * 1000);
    videoConfig.captureConfig.timeRanges = [pair1, pair2];
    var pair3 = NvTimePair(0, 30 * 1000);
    videoConfig.captureConfig.smartTimeRange = pair3;

    videoConfig.captureConfig.beautyConfig = NvBeautyConfig();
    videoConfig.captureConfig.beautyConfig?.categoricalArray = [
      NvBeautyCategorical.Skin,
      NvBeautyCategorical.MicroShape
    ];
    videoConfig.captureConfig.beautyConfig?.beautyEffectArray = [
      NvBeautyEffect.Standard,
      NvBeautyEffect.WhiteA,
      NvBeautyEffect.Rosy
    ];

    videoConfig.captureConfig.dualMenuItems = [
      NvCaptureMenuItem.device,
      NvCaptureMenuItem.dualtype,
      NvCaptureMenuItem.original
    ];
    videoConfig.captureConfig.dualConfig = NvDualConfig();
    videoConfig.captureConfig.dualConfig?.left = 50.0 / 375.0;
    videoConfig.captureConfig.dualConfig?.top = 50.0 / 666.67;
    videoConfig.captureConfig.dualConfig?.limitWidth = 200 / 375.0;
    videoConfig.captureConfig.dualConfig?.defaultType = NvDualType.topDown;
    videoConfig.captureConfig.dualConfig?.supportedTypes = [
      NvDualType.topDown,
      NvDualType.leftRight
    ];
    videoConfig.captureConfig.dualConfig?.autoDisablesMic = true;

    videoConfig.captureConfig.filterDefaultValue = 1.0;
    videoConfig.captureConfig.enableCaptureAlbum = true;
    videoConfig.captureConfig.autoDisablesMic = true;

    //编辑配置 albumConfig
    videoConfig.editConfig.editMenuItems = [
      NvEditMenuItem.release,
      NvEditMenuItem.download,
      NvEditMenuItem.text
    ];
    videoConfig.editConfig.resolution =
        NvVideoPreviewResolution.NvVideoPreviewResolution_1080;
    videoConfig.editConfig.fps = 25;
    videoConfig.editConfig.minEffectDuration = 1000;
    videoConfig.editConfig.minAudioDuration = 3000;
    videoConfig.editConfig.captionColor = "#FFA500";
    videoConfig.editConfig.captionColorList = [
      "#FFFFFF",
      "#000000",
      "#0099F6",
      "#50C23B",
    ];
    videoConfig.editConfig.supportedCaptionStyles = [
      NvImageCaptionStyle.none,
      NvImageCaptionStyle.outline
    ];
    videoConfig.editConfig.editModeSource = NvEditModeSource.firstAsset;
    videoConfig.editConfig.editMode = NvEditMode.NvEditMode9v16;
    videoConfig.editConfig.supportedEditModes = [
      NvEditMode.NvEditMode9v16,
      NvEditMode.NvEditMode16v9,
      NvEditMode.NvEditMode3v4,
      NvEditMode.NvEditMode4v3,
      NvEditMode.NvEditMode1v1,
      NvEditMode.NvEditMode18v9,
      NvEditMode.NvEditMode9v18,
      NvEditMode.NvEditMode8v9,
      NvEditMode.NvEditMode9v8
    ];
    videoConfig.editConfig.bubbleConfig = NvBubbleConfig();
    videoConfig.editConfig.bubbleConfig?.titleTheme = NvLabelTheme();
    videoConfig.editConfig.bubbleConfig?.titleTheme?.textColor = "#0000FF";
    videoConfig.editConfig.bubbleConfig?.backgroundBlurStyle =
        NvBubbleBgBlurStyle.light;

    videoConfig.editConfig.filterDefaultValue = 1.0;
    videoConfig.editConfig.maxVolume = 1;

    //导出配置 compile Config
    videoConfig.compileConfig.resolution =
        NvVideoCompileResolution.NvVideoCompileResolution_720;
    videoConfig.compileConfig.fps = 25;
    videoConfig.compileConfig.bitrateGrade =
        NvsCompileVideoBitrateGrade.NvsCompileBitrateGradeHigh;
    videoConfig.compileConfig.bitrate = -1;
    videoConfig.compileConfig.autoSaveVideo = true;

    //模版配置 compile Config
    videoConfig.templateConfig.maxSelectCount = 5;
    videoConfig.templateConfig.useAutoCut = false;

    //模型配置 model Config
    // videoConfig.modelConfig.use240 = true;
    // videoConfig.modelConfig.face240 = "ms_face240_v2.0.8.model";

    //以”capture_capture_close_bt“为例
    var buttonTheme = NvButtonTheme();
    buttonTheme.imageName = "homepage_logo";

    //以”capture_duration_label“为例
    var labelTheme = NvLabelTheme();
    labelTheme.textColor = "#FF0000";

    //以”capture_music_menu_view“为例
    var viewTheme = NvViewTheme();
    viewTheme.backgroundColor = "#FF0000";

    //以”capture_capture_record_bt_set“为例
    var record = NvRecordBtTheme();
    record.minimumTrackTintColor = "#FF0000";

    var customTheme = {
      NvCaptureCloseBtKey: buttonTheme,
      NvCaptureDurationLabelKey: labelTheme,
      NvCaptureMusicMenuViewKey: viewTheme,
      NvCaptureRecordBtSetKey: record
    };

    videoConfig.captureConfig.customTheme = customTheme;
  }

  @override
  Widget build(BuildContext context) {
    dataSource = [
      {
        "icon": "assets/images/homepage_capture@2x.png",
        "label": S.of(context).setting_item_capture,
        "fuc": () {
          shortVideoOperator().startVideoCapture(config: videoConfig);
        }
      },
      {
        "icon": "assets/images/homepage_dual@2x.png",
        "label": S.of(context).setting_item_dual,
        "fuc": () {
          shortVideoOperator().startVideoDualCapture(config: videoConfig);
        }
      },
      {
        "icon": "assets/images/homepage_edit@2x.png",
        "label": S.of(context).setting_item_edit,
        "fuc": () {
          shortVideoOperator().startSelectFilesForEdit(config: videoConfig);
        }
      },
      {
        "icon": "assets/images/homepage_draft@2x.png",
        "label": S.of(context).draft,
        "fuc": () {
          var page = DraftListPage(
              title: S.of(context).draft, videoConfig: videoConfig);
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return page;
              },
            ),
          );
        }
      },
    ];
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 0, 1),
              Color.fromRGBO(42, 49, 60, 1),
            ],
            begin: Alignment(0.0, 0.0),
            end: Alignment(1.0, 1.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 28),
              child: Text(
                S.of(context).new_materials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 28, right: 28),
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: Image.asset(
                  "assets/images/homepage_banner@2x.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 功能列表
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 28, right: 28),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(33, 39, 44, 1),
                      Color.fromRGBO(40, 47, 59, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 功能列表标题
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 38, left: 28, right: 28),
                      child: Text(
                        S.of(context).select_function_noti,
                        style: const TextStyle(
                          color: Color.fromRGBO(170, 170, 170, 1),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 28, right: 28),
                      child: Text(
                        S.of(context).function_list,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(
                          top: 0, left: 28, bottom: 58, right: 28),
                      children: dataSource
                          .map((e) => homePageFunctionButton(
                                icon: e["icon"] ?? "",
                                label: e["label"] ?? "",
                                onTap: e["fuc"] ?? () {},
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
