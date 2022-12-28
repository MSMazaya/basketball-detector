import 'package:flutter/material.dart';
import 'package:mobile_app/views/layout_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LayoutViewModel>.reactive(
      viewModelBuilder: () => LayoutViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 43, 77, 190),
            title: Text('Basketball Tracker'),
          ),
          body: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 41, 47, 172),
                  Color.fromARGB(255, 18, 26, 62),
                  Color.fromARGB(255, 18, 26, 62),
                  Color.fromARGB(255, 18, 26, 62),
                  Color.fromARGB(255, 18, 26, 62),
                  Color.fromARGB(255, 90, 54, 198),
                ],
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 50, bottom: 10),
              width: !(model.currentTabIndex == 1)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width * 0.8,
              child: model.getViewForIndex(model.currentTabIndex),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff101832),
            unselectedItemColor: Colors.white,
            currentIndex: model.currentTabIndex,
            onTap: model.setTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_basketball, color: Colors.white),
                label: "Field",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.numbers, color: Colors.white),
                label: "Scores",
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.white),
                label: "Configuration",
                backgroundColor: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
