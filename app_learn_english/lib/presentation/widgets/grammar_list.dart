import 'package:app_learn_english/models/grammar_model.dart';
import 'package:app_learn_english/presentation/screens/grammar_detail_page.dart';
import 'package:app_learn_english/presentation/widgets/grammar.dart';
import 'package:flutter/material.dart';

// class GrammarListWidget extends StatefulWidget {
//
//
//   @override
//   State<GrammarListWidget> createState() => _GrammarListWidgetState();
// }
//
// class _GrammarListWidgetState extends State<GrammarListWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         color: Colors.blueGrey,
//         child: ListView.builder(
//             itemBuilder:
//         ));
//   }
// }

class GrammarListWidget extends StatelessWidget {
  final List<GrammarModel> listGrammars;

  GrammarListWidget(this.listGrammars);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blueGrey,
      child: ListView.builder(
          itemCount: listGrammars.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GrammarDetailPage(
                        name: listGrammars[index].name,
                        content: listGrammars[index].content),
                  ),
                );
              },
              child: GrammarWidget(index + 1, listGrammars[index].name),
            );
          }),
    );
  }
}
