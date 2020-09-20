import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Category.dart';
import 'package:zwm_app/constants.dart';

class FilterDialog extends StatefulWidget {
  final List<String> selectedCategories;
  final Function applyFilter;

  FilterDialog({
    this.selectedCategories,
    this.applyFilter,
  });

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  // List<String> _filters = [
  //   'Bulk Food',
  //   'Community Composting Surplus Food',
  //   'Furry Friends Corner',
  //   'Household Products',
  //   'Personal Care Products',
  //   'Repair Services',
  //   'Sustainable Business Services',
  //   'Thrift Shops Swap Corners',
  //   'Traditional Wet Markets',
  //   'Upcycling Recycling Waste Disposal Centres'
  // ];
  List<Category> _categories = categories;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Text(
        'Categories',
        style: _theme.textTheme.headline1,
      ),
      content: Container(
        width: _size.width,
        child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (BuildContext context, int index) {
            final category = _categories[index];

            return CheckboxListTile(
              title: Text(category.title, style: _theme.textTheme.bodyText1),
              value: widget.selectedCategories.contains(category.title),
              activeColor: primaryColor,
              onChanged: (bool value) {
                if (value) {
                  if (!widget.selectedCategories.contains(category.title)) {
                    setState(() {
                      widget.selectedCategories.add(category.title);
                    });
                  }
                } else {
                  if (widget.selectedCategories.contains(category.title)) {
                    setState(() {
                      widget.selectedCategories.removeWhere(
                          (String value) => value == category.title);
                    });
                  }
                }
              },
            );
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: new Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text('Apply'),
          onPressed: () {
            Navigator.of(context).pop();
            widget.applyFilter(widget.selectedCategories);
          },
        )
      ],
    );
  }
}
