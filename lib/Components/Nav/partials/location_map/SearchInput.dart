import 'package:flutter/material.dart';
import 'package:zwm_app/constants.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController controller;
  final Function filter;

  const SearchInput({@required this.controller, @required this.filter});

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: paddingSmall),
        child: TextField(
          onChanged: (value) {
            debugPrint('controller value inside: ' + widget.controller.text);
            widget.filter(value);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 5),
            isDense: true,
            hintText: 'Search',
          ),
          controller: widget.controller,
        ),
      ),
    );
  }
}
