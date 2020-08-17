import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zwm_app/constants.dart';

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  List<String> _filters = [
    'Bulk Food',
    'Community Composting Surplus Food',
    'Furry Friends Corner',
    'Household Products',
    'Personal Care Products',
    'Repair Services',
    'Sustainable Business Services',
    'Thrift Shops Swap Corners',
    'Traditional Wet Markets',
    'Upcycling Recycling Waste Disposal Centres'
  ];
  List<String> _selectedFilters = [];

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
            itemCount: _filters.length,
            itemBuilder: (BuildContext context, int index) {
              final cityName = _filters[index];

              return CheckboxListTile(
                title: Text(cityName, style: _theme.textTheme.bodyText1),
                value: _selectedFilters.contains(cityName),
                activeColor: primaryColor,
                onChanged: (bool value) {
                  if (value) {
                    if (!_selectedFilters.contains(cityName)) {
                      setState(() {
                        _selectedFilters.add(cityName);
                      });
                    }
                  } else {
                    if (_selectedFilters.contains(cityName)) {
                      setState(() {
                        _selectedFilters
                            .removeWhere((String city) => city == cityName);
                      });
                    }
                  }
                  // widget
                  //     .onSelectedFiltersListChanged(_tempSelectedFilters);
                },
              );
            }),
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
            // Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
