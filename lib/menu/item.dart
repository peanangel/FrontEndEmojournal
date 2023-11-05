import 'package:flutter/material.dart';
import '../models/activity.dart';

class Item extends StatefulWidget {
  final Activity activity;
  final ValueChanged<bool> onSelected;

  const Item({
    Key? key,
     required this.activity,
     required this.onSelected,
  }) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelected(_isSelected);
        });
      },
      child: Container(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 70,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.pink,
                  border: _isSelected ? Border.all(width: 2.0) : null),
              child: Image.network(
                widget.activity.img,
                height: 10,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(widget.activity.name)
          ],
        ),
      ),
    );
  }
}
