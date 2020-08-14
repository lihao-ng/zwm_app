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
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    super.initState();
    items.addAll(duplicateItems);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    // void filterSearchResults(String query) {
    //   List<String> dummySearchList = List<String>();
    //   dummySearchList.addAll(duplicateItems);

    //   if (query.isNotEmpty) {
    //     List<String> dummyListData = List<String>();
    //     dummySearchList.forEach((item) {
    //       if (item.contains(query)) {
    //         dummyListData.add(item);
    //       }
    //     });

    //     setState(() {
    //       items.clear();
    //       items.addAll(dummyListData);
    //     });

    //     return;
    //   } else {
    //     setState(() {
    //       items.clear();
    //       items.addAll(duplicateItems);
    //     });
    //   }
    // }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: paddingMid,
      ),
      width: _size.width / 1.5,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Focus(
                    child: TextField(
                      onChanged: (value) {
                        debugPrint('controller value inside: ' +
                            widget.controller.text);
                        widget.filter(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                      controller: widget.controller,
                    ),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(height: 20),
          // if (widget.controller.text.toString() != '')
          //   Visibility(
          //     visible: widget.controller.text.toString() != '',
          //     child: Expanded(
          //       child: ListView.separated(
          //         physics: BouncingScrollPhysics(),
          //         scrollDirection: Axis.vertical,
          //         shrinkWrap: true,
          //         itemCount: items.length,
          //         itemBuilder: (context, index) {
          //           return Container(
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               color:
          //                   (index % 2 == 0) ? accentColor : Colors.grey[100],
          //             ),
          //             child: ListTile(
          //               leading: CircleAvatar(
          //                 backgroundImage:
          //                     AssetImage('assets/images/placeholder_shop.jpg'),
          //               ),
          //               title: Text('${items[index]}',
          //                   style: _theme.textTheme.bodyText1,
          //                   overflow: TextOverflow.ellipsis),
          //               subtitle: Text(
          //                 'Location here akjshdkjash aksjdha',
          //                 style: _theme.textTheme.caption,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //               trailing: Icon(Icons.keyboard_arrow_right),
          //             ),
          //           );
          //         },
          //         separatorBuilder: (BuildContext context, int index) {
          //           return SizedBox(
          //             height: 5,
          //           );
          //         },
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
