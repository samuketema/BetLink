import 'package:betlink/Firebase/buildbrokers.dart';
import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../utils/data.dart';
import '../widgets/broker_item.dart';
import '../widgets/company_item.dart';
import '../widgets/custom_textbox.dart';
import '../widgets/icon_box.dart';

class BrokersPage extends StatefulWidget {
  static const String id = 'brokes_page';
  const BrokersPage({Key? key}) : super(key: key);

  @override
  _BrokersPageState createState() => _BrokersPageState();
}

class _BrokersPageState extends State<BrokersPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: AppColor.appBgColor,
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
    return const Row(
      children: [
        Expanded(
          child: CustomTextBox(
            hint: "Search",
            prefix: Icon(Icons.search, color: Colors.grey),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconBox(
          bgColor: Colors.green,
          radius: 10,
          child: Icon(Icons.filter_list_rounded, color: Colors.white),
        )
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Companies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildCompanies(),
          const SizedBox(
            height: 20,
          ),
          BuildBrokers(),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  int _selectedCategory = 0;
  _buildCompanies() {
    List<Widget> lists = List.generate(
      companies.length,
      (index) => CompanyItem(
        data: companies[index],
        color: AppColor.listColors[index % 10],
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
