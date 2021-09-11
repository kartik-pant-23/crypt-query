import 'package:crypt_query/models/Currency.dart';
import 'package:crypt_query/models/Settings.dart';
import 'package:crypt_query/screens/DetailsScreen.dart';
import 'package:crypt_query/screens/SettingsScreen.dart';
import 'package:crypt_query/services/currencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

class CurrenciesList extends StatefulWidget {
  @override
  _CurrenciesListState createState() => _CurrenciesListState();
}

class _CurrenciesListState extends State<CurrenciesList> {
  int _currentPage = 1;
  Widget currenciesShimmerList() {
    return Shimmer.fromColors(
      baseColor: Color(0xffd9e2ec).withOpacity(0.50),
      highlightColor: Color(0xffbcccdc),
      child: ListView.separated(
        itemCount: 20,
        itemBuilder: (_, __) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 40, width: 40, color: Color(0xff486f51)),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 12, width: 60, color: Color(0xff486f51)),
                        SizedBox(height: 8),
                        Container(
                            height: 8,
                            width: double.infinity,
                            color: Color(0xff486f51))
                      ],
                    ),
                  )
                ],
              ));
        },
        separatorBuilder: (_, __) {
          return Divider(thickness: 1, color: Colors.white12);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _listHeader = GestureDetector(
        onTap: () {
          Navigator.push(context, PageRouteBuilder(
            pageBuilder: (ctx, anim1, anim2) => const SettingsScreen(),
            transitionsBuilder: (ctx, anim1, anim2, child) {
              return SlideTransition(
                position: anim1.drive(Tween(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero
                ).chain(CurveTween(curve: Curves.easeOut))),
                child: child
              );
            }
          ));
        },
        child: Consumer<Settings>(
          builder: (context, settings, child) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.pinkAccent, Colors.amberAccent])),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("CONFIGURATIONS",
                            style: TextStyle(
                                letterSpacing: 1.5,
                                color: Color(0xffd9e2ec),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: Text("Per Page Count\n${settings.perPage}",
                                    textAlign: TextAlign.center)),
                            Expanded(
                                child: Text("Currency\n${settings.currency}",
                                    textAlign: TextAlign.center))
                          ],
                        )
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward, size: 32.0)
                ],
              ),
            );
          }
        )
    );

    Widget _pageIndex = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  if (_currentPage > 1)
                    setState(() {
                      _currentPage--;
                    });
                },
                child: Icon(Icons.keyboard_arrow_left,
                    size: 24, color: Colors.amber)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text("PAGE $_currentPage",
                  style: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold)),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _currentPage++;
                  });
                },
                child: Icon(Icons.keyboard_arrow_right,
                    size: 24, color: Colors.amber))
          ],
        ));

    Widget _currencyItem(Currency item) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, PageRouteBuilder(
            pageBuilder: (ctx, anim1, anim2) => DetailsScreen(currency: item),
            transitionsBuilder: (ctx, anim1, anim2, child) {
              return SlideTransition(
                  position: anim1.drive(Tween(
                      begin: Offset(1.0, 0.0),
                      end: Offset.zero
                  ).chain(CurveTween(curve: Curves.easeOut))),
                  child: child
              );
            }));
          },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              item.logoUrl.endsWith(".svg")
                  ? SvgPicture.network(item.logoUrl, height: 40, width: 40)
                  : Image.network(item.logoUrl, height: 40, width: 40),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${item.name}",
                        style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(item.symbol),
                        Expanded(child: Container()),
                        Text(item.priceDelta ?? "-",
                            style: TextStyle(
                                color: (item.priceDelta ?? "-").startsWith("-")
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.bold)),
                        Expanded(child: Container()),
                        Text(item.price ?? "-",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffd9e2ec)))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return FutureBuilder<List<Currency>?>(
      future: loadCurrenciesData(
          currency: context.watch<Settings>().currency,
          perPage: context.watch<Settings>().perPage,
          page: _currentPage.toString()
      ),
      builder: (BuildContext context, AsyncSnapshot<List<Currency>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return currenciesShimmerList();
        } else if (snapshot.hasError) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "We cannot load data for the moment! Something went wrong.",
                style: TextStyle(color: Colors.red)),
          ));
        } else {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (ctx, index) {
              Currency item = snapshot.data!.elementAt(index);
              if (index == snapshot.data!.length - 1) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _currencyItem(item),
                    SizedBox(height: 16),
                    _pageIndex
                  ],
                );
              } else if (index == 0) {
                return Column(
                  children: [_listHeader, _currencyItem(item)],
                );
              }
              return _currencyItem(item);
            },
            separatorBuilder: (ctx, item) {
              return Divider(thickness: 1, color: Colors.white12);
            },
          );
          // return currenciesShimmerList();
        }
      },
    );
  }
}
