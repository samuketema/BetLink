import 'package:flutter/material.dart';
import '../theme/color.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.data,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  final data;
  final bool selected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(

        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        margin: EdgeInsets.only(right: 10),
        width: 70,
        height: 50,
        decoration: BoxDecoration(
          color: selected ? AppColor.primary : AppColor.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              spreadRadius: .5,
              blurRadius: .5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              data["icon"],
              size: 15,
              color: selected ? Colors.white : Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                data["name"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: selected ? Colors.white : AppColor.darker,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
