import 'package:flutter/material.dart';
import 'package:nvshortvideo/nvshortvideo.dart';
import 'dart:io';
import 'package:nvshortvideodemo/generated/l10n.dart';

class DraftListPage extends StatefulWidget {
  const DraftListPage(
      {super.key, required this.title, required this.videoConfig});

  final String title;
  final NvVideoConfig videoConfig;

  @override
  DraftListPageState createState() => DraftListPageState();
}

class DraftListPageState extends State<DraftListPage> {
  var draftList = [];

  DraftListPageState();

  @override
  void initState() {
    super.initState();
    loadDraftListData();
    shortVideoOperator().setDraftUpdateHandler(() => loadDraftListData());
  }

  @override
  void dispose() {
    super.dispose();
    // !!!: 释放草稿列表监听/release draft list listener
    shortVideoOperator().setDraftUpdateHandler(null);
  }

  void loadDraftListData() async {
    var result = await shortVideoOperator().getDraftList();
    List? tmpList = result['response'];
    setState(() {
      if (tmpList != null) {
        draftList.clear();
        draftList.addAll(tmpList);
      } else {
        draftList = [];
      }

      // Dictionary dic = draftList[0];
      // coverImagePath: 封面图 String
      // draftInfo: 描述 String
      // projectId: 草稿id String
    });
  }

  deleteDraft(var draftItem) async {
    shortVideoOperator().deleteDraft(draftItem["projectId"]);
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
          backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
          foregroundColor: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
        body: _blendModeListView());
  }

  Widget _blendModeListView() {
    var listview = ListView.builder(
      itemCount: draftList.length + 1,
      padding: const EdgeInsets.only(left: 10, right: 10),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              S.of(context).draft_noti,
              style: const TextStyle(
                color: Color.fromRGBO(128, 128, 128, 1),
                fontSize: 13,
              ),
              textAlign: TextAlign.left,
            ),
          );
        } else {
          var itemData = draftList[index - 1];
          String draftInfo = itemData["draftInfo"];
          if (draftInfo == "") {
            draftInfo = S.of(context).add_description;
          }

          var projectId = itemData["projectId"];
          return Dismissible(
            key: Key(projectId),
            onDismissed: (direction) {
              deleteDraft(itemData);
              setState(() {
                draftList.remove(itemData);
              });
            },
            background: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).right_delete,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              padding: const EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              child: Text(
                S.of(context).left_delete,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 打开草稿
                // Open draft
                shortVideoOperator()
                    .reeditDraft(projectId, config: widget.videoConfig);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.black,
                      ),
                      child: Image.file(
                        File(itemData["coverImagePath"]),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 10.0, 0.0),
                      child: Text(
                        draftInfo,
                        style: const TextStyle(
                          color: Color.fromRGBO(196, 196, 196, 1),
                          fontSize: 12,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis, // 添加溢出省略号
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
    return listview;
  }
}
