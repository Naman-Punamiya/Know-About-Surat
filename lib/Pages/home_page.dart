import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:know_about_surat/models/fooditems.dart';
import 'package:know_about_surat/models/cards.dart';
import 'package:know_about_surat/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  TextEditingController _searchController = TextEditingController();
  String _listeningWords = "";
  List<Map<String, dynamic>> _searcheditem = [];

  @override
  void initState() {
    _searcheditem = fooditems;
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    bool available = await _speechToText.initialize();
    if (!mounted) return;
    setState(() {
      _isListening = available;
    });
  }

  void _startListening() async {
    await _speechToText.listen(onResult: (result) {
      setState(() {
        _listeningWords = result.recognizedWords;
        _searchController.text =
            _listeningWords; // Update the TextField with recognized words
        _filter(
            _listeningWords); // Optional: automatically filter the items based on recognized words
      });
    });
    setState(() {
      _isListening = true;
    });
  }

  void _filter(String keyword) {
    List<Map<String, dynamic>> results = [];
    if (keyword.isEmpty) {
      results = fooditems;
    } else {
      results = fooditems
          .where((food) =>
              food["name"].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _searcheditem = results;
    });
  }

  void signUserOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.nights_stay_outlined),
              onPressed: () =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            ),
            title: Text(
              "Know About Surat",
              style: GoogleFonts.quicksand(),
            ),
            actions: [
              IconButton(
                  onPressed: signUserOut, icon: const Icon(Icons.logout)),
            ],
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(
                  Icons.fastfood_rounded,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (value) => _filter(value),
                          style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                          decoration: InputDecoration(
                            labelText: "Search",
                            labelStyle: GoogleFonts.quicksand(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.w600),
                            suffix: IconButton(
                                onPressed:
                                    // _speechToText.isListening
                                    //     ? _stopListening
                                    //     :
                                    _startListening,
                                icon: Icon(
                                    _isListening ? Icons.mic : Icons.mic_none)),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: _searcheditem.length,
                            itemBuilder: (context, index) => card(
                                  context,
                                  _searcheditem[index]['name'],
                                  _searcheditem[index]['path'],
                                  _searcheditem[index]['info'],
                                  _searcheditem[index]['loc'],
                                  _searcheditem[index]['price'],
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).colorScheme.tertiary,
                                )),
                      ),
                    ],
                  )),
              Container(
                color: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.all(8),
                child:
                    ListView(
                  children: categories.map((category) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCategoryHeader(context, category["title"]),
                        buildCategoryGrid(context, category["items"]),
                      ],
                    );
                  }).toList(),
                ),
              ),
              ],
          ),
        ),
      ),
    );
  }
}

Widget buildCategoryHeader(BuildContext context, String title) {
  return Container(
    padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
    child: Text(
      title,
      style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary, fontSize: 32),
    ),
  );
}

Widget buildCategoryGrid(
    BuildContext context, List<Map<String, String>> items) {
  return Container(
    decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(
                color: Colors.black45,
                width: 0.75,
                style: BorderStyle.solid,
                strokeAlign: BorderSide.strokeAlignInside))),
    child: GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 8,
        childAspectRatio: 1.25,
      ),
      children: items.map<Widget>((item) {
        final name = item["name"] ?? '';
        final image = item["image"] ?? '';
        return places(context, name, image);
      }).toList(),
    ),
  );
}
