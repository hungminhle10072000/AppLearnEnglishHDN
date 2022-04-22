import 'package:app_learn_english/blocs/list_grammar_bloc.dart';
import 'package:app_learn_english/presentation/widgets/grammar_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/StringRenderUtil.dart';

class GrammarListPage extends StatefulWidget {
  const GrammarListPage({Key? key}) : super(key: key);

  @override
  State<GrammarListPage> createState() => _GrammarListPageState();
}

class _GrammarListPageState extends State<GrammarListPage> {
  @override
  void initState() {
    context.read<ListGrammarBloc>().add(ListGrammarEventLoad());
  }

  final searchController = TextEditingController();

  bool isSearching = false;

  late String keyword='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: !isSearching
            ? TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'home');
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ))
            : null,
        title: !isSearching
            ? Text(
                "Danh sách ngữ pháp",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              )
            : TextField(
                controller: searchController,
                onChanged: (text) {
                  setState(() {
                    keyword = text;
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: GestureDetector(
                      onTap: () {
                        // topicVocabularyBloc.topicEventSink.add(
                        //     SearchTopicVocabularyEvent(
                        //         searchController.text.toString()));
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Tìm kiếm..."),
              ),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = !this.isSearching;
                      setState(() {
                        keyword = '';
                      });
                      searchController.clear();
                    });
                  },
                  icon: Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      this.isSearching = !this.isSearching;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<ListGrammarBloc, ListGrammarState>(
        builder: (context, state) {
          if (state is ListGrammarLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ListGrammarLoadedState) {
            if(keyword.isEmpty){
              return GrammarListWidget(state.listGrammar);
            } else {
              return GrammarListWidget(state.listGrammar.where((element) => StringRenderUtil.searching(element.name, keyword)).toList());
            }
          }
          if (state is ListGrammarErrorState) {
            return Center(
              child: Text(state.error.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
