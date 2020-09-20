import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Merchants/partials/MerchantCard.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Category.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/Services/MerchantServices.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class MerchantsList extends StatefulWidget {
  final Category category;

  const MerchantsList({@required this.category});

  @override
  _MerchantsListState createState() => _MerchantsListState();
}

class _MerchantsListState extends State<MerchantsList> {
  List<Merchant> _merchants = [];
  int _page = 1;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _loadMerchants();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMerchants();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMerchants() {
    MerchantServices().index(
      categories: [widget.category.value],
      page: _page,
      onSuccess: (List<Merchant> merchants, page) {
        if (merchants.length == 0) {
          return;
        }
        setState(() {
          _page = page + 1;
          _merchants.addAll(merchants);
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

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingLarge,
          vertical: paddingMid,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(
              1,
              Text(
                widget.category.title,
                style: _theme.textTheme.headline1,
              ),
            ),
            SizedBox(height: spacingSmall),
            Expanded(
              child: _merchants.length == 0
                  ? Center(
                      child: SpinKitPouringHourglass(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : ListView.separated(
                      controller: _scrollController,
                      itemCount: _merchants.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: spacingMid,
                        thickness: 2,
                      ),
                      itemBuilder: (context, index) {
                        return MerchantCard(
                          merchant: _merchants[index],
                          press: () => {
                            Navigator.pushNamed(context, '/merchant-detail',
                                arguments: _merchants[index]),
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
