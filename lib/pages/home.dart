import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Firebase/build_recents.dart';
import '../utils/data.dart';
import '../widgets/category_item.dart';
import '../Firebase/build_populars.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homepage';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.grey.shade200,
              pinned: true,
              snap: true,
              floating: true,
              title: _buildHeader(),
            ),
            SliverToBoxAdapter(child: _buildBody())
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(child: Image.asset('assets/images/home.jpg')),
            const Text(
              "BetLink",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Icon(FontAwesomeIcons.magnifyingGlass)
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Popular Listings",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          BuildPopulars(),
          const SizedBox(
            height: 20,
          ),
          _buildCategories(),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Recent Listings",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          BuildRecents(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  int _selectedCategory = 0;
  Widget _buildCategories() {
    List<Widget> lists = List.generate(
      categories.length,
      (index) => CategoryItem(
        data: categories[index],
        selected: index == _selectedCategory,
        onTap: () {
          setState(() {
            _selectedCategory = index;
          });
        },
      ),
    );
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }
}
