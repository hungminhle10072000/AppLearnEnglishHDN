import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class GrammarDetailPage extends StatefulWidget {
  final String name;
  final String content;

  const GrammarDetailPage({Key? key, required this.name, required this.content})
      : super(key: key);

  @override
  State<GrammarDetailPage> createState() => _GrammarDetailPageState();
}

class _GrammarDetailPageState extends State<GrammarDetailPage> {
  final HtmlEditorController controller =
      HtmlEditorController(processInputHtml: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chi tiết ngữ pháp',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                  visible: false,
                  child: ToolbarWidget(
                    // callbacks: Callbacks(onInit: () {
                    //   controller.disable();
                    // }),
                    callbacks: null,
                    controller: controller,
                    htmlToolbarOptions:
                        HtmlToolbarOptions(defaultToolbarButtons: [
                      OtherButtons(copy: false, paste: false),
                    ]),
                  )),
              HtmlEditor(
                callbacks: Callbacks(onInit: () {
                  controller.disable();
                  controller.setFullScreen();
                }),
                controller: controller,
                htmlToolbarOptions: HtmlToolbarOptions(
                  // toolbarPosition: ToolbarPosition.custom,
                  defaultToolbarButtons: [
                    OtherButtons(copy: false, paste: false),
                  ],
                ),
                htmlEditorOptions: HtmlEditorOptions(
                    autoAdjustHeight: false,
                    // darkMode: false,
                    hint: 'Đây là nội dung bài học',
                    shouldEnsureVisible: true,
                    initialText: widget.content),
                otherOptions: OtherOptions(
                  // height: MediaQuery.of(context).size.height -
                  //     AppBar().preferredSize.height,
                  height: MediaQuery.of(context).size.height -
                      AppBar().preferredSize.height -
                      40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
