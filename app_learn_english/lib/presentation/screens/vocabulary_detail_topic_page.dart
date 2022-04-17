import 'package:app_learn_english/presentation/widgets/vocabulary_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/list_vocabulary_bloc.dart';

class VocabularyDetailTopicPage extends StatefulWidget {
  const VocabularyDetailTopicPage({Key? key}) : super(key: key);

  @override
  State<VocabularyDetailTopicPage> createState() =>
      _VocabularyDetailTopicPageState();
}

class _VocabularyDetailTopicPageState extends State<VocabularyDetailTopicPage> {
  final searchController = TextEditingController();

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: !isSearching
            ? TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ))
            : null,
        title: !isSearching
            ? Text(
                "English 2022",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              )
            : TextField(
                controller: searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: GestureDetector(
                      onTap: () {
                        context.read<ListVocabularyBloc>().add(
                            ListVocabularyEventSearch(
                                searchController.text.toString()));
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
                    });
                    context.read<ListVocabularyBloc>().add(
                        ListVocabularyEventSearch(''));
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
      body: BlocBuilder<ListVocabularyBloc, ListVocabularyState>(
        builder: (context, state) {
          if (state is ListVocabularyLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ListVocabularyLoadedState) {
            return VocabularyListWidget(state.listVocabularies);
          }
          if (state is ListVocabularyErrorState) {
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
