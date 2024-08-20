import 'package:flutter/material.dart';
import '../theme/color.dart';
import '../utils/data.dart';
import '../widgets/broker_item.dart';
import '../widgets/company_item.dart';
import '../widgets/custom_textbox.dart';
import '../widgets/icon_box.dart';

class BrokersPage extends StatefulWidget {
  const BrokersPage({Key? key}) : super(key: key);

  @override
  _BrokersPageState createState() => _BrokersPageState();
}

class _BrokersPageState extends State<BrokersPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
    );
  }

  _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: CustomTextBox(
            hint: "Search",
            prefix: Icon(Icons.search, color: Colors.grey),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconBox(
          child: Icon(Icons.filter_list_rounded, color: Colors.white),
          bgColor: AppColor.secondary,
          radius: 10,
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
          _buildBrokers(),
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
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  _buildBrokers() {
    List<Widget> lists = List.generate(
      brokers.length,
      (index) => BrokerItem(
        data: brokers[index],
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(children: lists),
    );
  }
}
