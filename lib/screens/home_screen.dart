import 'package:emulatorapp/constants/constants.dart';
import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/providers/hostel_provider.dart';
import 'package:emulatorapp/widgets/network_error_message.dart';
import 'package:flutter/material.dart';
import 'package:emulatorapp/widgets/toogle_button.dart';
import 'package:provider/provider.dart';
import '../widgets/hostel_widget.dart';
import '../widgets/skeleton_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  bool isSearch;

  HomeScreen({required this.isSearch});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _genderIndex = 1;
  bool search = false;

  genderChange(genderIndex) {
    setState(() {
      _genderIndex = genderIndex;
    });
  }

  Future getData() async {
    await Provider.of<HostelProvider>(context).fetchAllHostels();
  }

  @override
  Widget build(BuildContext context) {
    final searchHostelData =
        Provider.of<HostelProvider>(context).searchHostelList;
    final _size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              // pinned:true,
              elevation: 0,
              expandedHeight: kSliverAppbarHeight,
              backgroundColor: Colors.white,
              floating: true,
              pinned: false,
              //snap: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Yellow.png',
                        fit: BoxFit.contain,
                        color: kPrimaryColor,
                        height: kSliverAppbarHeight * 0.3,
                      ),
                      SizedBox(height: kSliverAppbarHeight * 0.03),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/search-screen");
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 8.00),
                                height: kSliverAppbarHeight * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Search for Hostel",
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w500,
                                        fontSize: kTitleFontSize,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, "/favourite-hostel"),
                            child: Icon(
                              Icons.favorite,
                              color: kPrimaryColor,
                              size: kHeartIconSize,
                            ),
                          ),
                        ],
                      ),
                      widget.isSearch
                          ? Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Search Result",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! *
                                              4.2),
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 15.0, 0, 2.0),
                              child: ToggleButton(genderChange, _genderIndex),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            widget.isSearch
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 12),
                      child: GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            childAspectRatio:
                                _size.width / (_size.height / 1.5),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return HostelWidget(searchHostelData[index]);
                          },
                          itemCount: searchHostelData.length),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return NetworkErrorMessage();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Consumer<HostelProvider>(
                              builder: (context, value, _) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, bottom: 12),
                                  child: GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 250,
                                      childAspectRatio:
                                          _size.width / (_size.height / 1.4),
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemBuilder: (context, index) {
                                      return widget.isSearch
                                          ? Text(value.searchHostelList.length
                                              .toString())
                                          : _genderIndex == 0
                                              ? HostelWidget(
                                                  value.featuredFemaleHostelList[
                                                      index],
                                                )
                                              : HostelWidget(
                                                  value.featuredMaleHostelList[
                                                      index],
                                                );
                                    },
                                    itemCount: widget.isSearch
                                        ? value.searchHostelList.length
                                        : _genderIndex == 0
                                            ? value
                                                .featuredFemaleHostelList.length
                                            : value
                                                .featuredMaleHostelList.length,
                                  ),
                                );
                              },
                            );
                          } else {
                            return SkeletonWidget();
                          }
                        })),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      //   child: GestureDetector(
      //     onTap: () {
      //       Navigator.push(context, MaterialPageRoute(builder: (_) {
      //         return RegisterHostelScreen();
      //       }));
      //     },
      //     child: Container(
      //       height: kBottomNavigationBarHeight,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(16),
      //         color: kPrimaryColor,
      //       ),
      //       child: Center(
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: const [
      //             Icon(
      //               Icons.add,
      //               color: Colors.white,
      //             ),
      //             Text(
      //               "Register Hostel",
      //               style: TextStyle(
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
