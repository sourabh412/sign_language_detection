import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import '../widgets/frequently_used.dart';
import '../widgets/profile.dart';
import '../widgets/read_sign.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;
  final PageController pageController = PageController();

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model4.tflite",
      labels: "assets/labels4.txt",
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await Tflite.close();
    pageController.dispose();
  }

  void selectPage(int index){
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView(
            onPageChanged: selectPage,
            controller: pageController,
            children: const [
              ReadSign(),
              FrequentlyUsed(),
              Profile(),
            ],
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        onTap: selectPage,
        selectedItemColor: Colors.indigo[500],
        unselectedItemColor: Colors.blueGrey,
        unselectedLabelStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner_outlined),
              activeIcon: Icon(Icons.document_scanner),
              label: "Read Sign"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.read_more_outlined),
              activeIcon: Icon(Icons.read_more),
              label: "Frequently used"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: "Profile"
          ),
        ],
      ),
    );
  }
}
