import 'package:flutter/material.dart';
import 'package:langwhale/components/result.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:provider/provider.dart';

import '../providers/data_provider.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YoutubePlayerController _controller;

  final TextEditingController _searchQueryController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
  }

  void controllerHandler({required String id, required int start}) {
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        startAt: start,
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _searchQueryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LangWhale'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search Expression',
                  style: TextStyle(fontSize: 24, color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.light,
                            spreadRadius: -1,
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 5),
                          Icon(Icons.search, color: AppColors.primary),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextField(
                              controller: _searchQueryController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search...',
                                contentPadding: EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            _query = _searchQueryController.text
                                .trim()
                                .replaceAll(RegExp(r' \s+'), ' ');
                          });
                          if (_query.isNotEmpty) {
                            Provider.of<DataProvider>(context, listen: false)
                                .isFirstFalse();
                            Provider.of<DataProvider>(context, listen: false)
                                .getData(query: _query);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.secondary),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          minimumSize:
                              MaterialStateProperty.all(const Size(100, 50)),
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                context.watch<DataProvider>().isFirst
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            'Use YouTube to improve your vocabulary. Langwhale provides you with the best examples from movies, series, cartoons and more. So that you can expand your vocabulary as fast as possible!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : FutureBuilder(
                        future: context.watch<DataProvider>().data,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (!snapshot.hasData) {
                              return Column(
                                children: const [
                                  SizedBox(height: 20),
                                  Center(child: Text('Not Found')),
                                ],
                              );
                            } else {
                              controllerHandler(
                                id: snapshot.data![0].id,
                                start: snapshot.data![0].matchedStartTimes[0],
                              );
                              return Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Result(
                                    controller: _controller,
                                    transcript: snapshot.data![0].transcript,
                                    query: _query,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            }
                          } else {
                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
