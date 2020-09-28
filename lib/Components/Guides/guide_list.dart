import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zwm_app/Components/Guides/partials/GuideCard.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Guide.dart';
import 'package:zwm_app/Services/GuideServices.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class GuideList extends StatefulWidget {
  final String category;

  const GuideList({@required this.category});

  @override
  _GuideListState createState() => _GuideListState();
}

class _GuideListState extends State<GuideList> {
  List<Guide> _guides = [];
  int _page = 1;

  bool _loading = true;

  String _searchValue = '';
  var searchController = TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _loadGuides();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        _loadGuides();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _loadGuides({search = false}) {
    _loading = true;

    GuideServices().index(
      search: _searchValue,
      category: widget.category,
      page: search == false ? _page : 1,
      limit: 300,
      onSuccess: (List<Guide> guides, page) {
        setState(() {
          if (search == true) {
            _guides.clear();
          }

          _guides.addAll(guides);

          _loading = false;
        });
      },
      onError: (response) {
        Navigator.of(context).pop();
        errorAlert(
          context,
          title: "An error has occured!",
          body: response,
        );
      },
    );
  }

  _filterSearchResults(String query) {
    setState(() {
      _searchValue = query;
    });

    _loadGuides(search: true);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.all(paddingMid),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.category,
              style: _theme.textTheme.headline1,
            ),
            SizedBox(height: spacingSmall),
            TextField(
              controller: searchController,
              onChanged: (value) {
                _filterSearchResults(value);
              },
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: paddingMid + 2,
                  horizontal: paddingMid,
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search object or material',
                hintStyle: TextStyle(height: 1.5),
              ),
            ),
            SizedBox(height: spacingMid),
            Expanded(
              child: _loading == true
                  ? Center(
                      child: SpinKitPouringHourglass(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : _guides.length == 0
                      ? Center(
                          child: Text(
                            'No results found.',
                            style: _theme.textTheme.headline3,
                          ),
                        )
                      : ListView.separated(
                          controller: _scrollController,
                          itemCount: _guides.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            height: spacingMid,
                            thickness: 2,
                          ),
                          itemBuilder: (context, index) {
                            return GuideCard(
                              guide: _guides[index],
                              press: () => {
                                Navigator.pushNamed(context, '/guide-detail',
                                    arguments: _guides[index]),
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
