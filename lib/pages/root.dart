import 'package:betlink/pages/dashboard.dart';
import 'package:betlink/pages/settings.dart';
import 'package:flutter/material.dart';
import '../pages/explore.dart';
import '../theme/color.dart';
import '../widgets/bottombar_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';

class RootApp extends StatefulWidget {

  static const String id = 'rootapp';
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int _activeTab = 0;
  final List<String> _barItemDescriptions = [
  'Home', // Description for the first item (Home)
  'Brokers', // Description for the second item (Brokers)
  'Dashboard', // Description for the third item (Dashboard)
  'Settings', // Description for the fourth item (Settings)
];

  final List _barItems = [
    {
      "icon": Icons.home_outlined,
      "active_icon": Icons.home_rounded,
      "page": HomePage(),
    },
    {
      "icon": FontAwesomeIcons.peopleGroup,
      "active_icon": FontAwesomeIcons.peopleGroup,
      "page": BrokersPage(),
    },
    {
      "icon": Icons.dashboard,
      "active_icon": Icons.dashboard_outlined,
      "page": DashboardScreen(),
    },
    {
      "icon": Icons.settings_outlined,
      "active_icon": Icons.settings_rounded,
      "page": SettingsScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: _buildPage(),
      floatingActionButton: _buildBottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget _buildPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        _barItems.length,
        (index) => _barItems[index]["page"],
      ),
    );
  }

  Widget _buildBottomBar() {
  return Container(
    height: 60,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
    decoration: BoxDecoration(
      color: AppColor.bottomBarColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
          spreadRadius: 1,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        _barItems.length,
        (index) {
          final isActive = _activeTab == index;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomBarItem(
                isActive
                    ? _barItems[index]["active_icon"]
                    : _barItems[index]["icon"],
                isActive: isActive,
                activeColor: AppColor.primary,
                onTap: () {
                  setState(() {
                    _activeTab = index;
                  });
                },
              ),
               // Add some spacing between icon and description
              Text(
                _barItemDescriptions[index],
                style: TextStyle(
                  color: isActive ? AppColor.primary : Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

}
