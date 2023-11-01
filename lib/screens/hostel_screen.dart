
import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/models/hostel.dart';
import 'package:emulatorapp/providers/hostel_detail.dart';
import 'package:emulatorapp/widgets/network_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:emulatorapp/widgets/comment_hostel.dart';
import 'package:emulatorapp/widgets/discrption_container.dart';
import 'package:emulatorapp/widgets/gallery_container.dart';
import 'package:emulatorapp/widgets/hostel_banner.dart';
import 'package:emulatorapp/widgets/hostel_features.dart';
import 'package:emulatorapp/widgets/hostel_information.dart';
import 'package:emulatorapp/widgets/map_container.dart';

class HostelScreen extends StatelessWidget {
  final HostelModel hostel;
  // final List<String>? favHostel;

  const HostelScreen(
    this.hostel, {Key? key},
    // this.favHostel,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<HostelDetailProvider>(context, listen: false)
            .fetchHostelData(hostel.slug),
        builder: (BuildContext context, AsyncSnapshot<dynamic> dataSnapshot) {
          if (dataSnapshot.hasError) {
            return const NetworkErrorMessage();
          }
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return CustomScrollView(slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 50,
                backgroundColor: Theme.of(context).primaryColor,
                systemOverlayStyle: SystemUiOverlayStyle.light,
                // brightness: Brightness.dark,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    hostel.name,
                    style: const TextStyle(
                      letterSpacing: -1.2,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                ),
                elevation: 0,
              ),
              SliverToBoxAdapter(
                child: HostelBanner(img: hostel.logo),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  )),
                ),
              )
            ]);
          } else {
            return Consumer<HostelDetailProvider>(
              builder: (
                ctx,
                value,
                _,
              ) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      expandedHeight: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          hostel.name,
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical! * 2.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        centerTitle: true,
                      ),
                      elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.light,
                    ),
                    SliverToBoxAdapter(
                      child: HostelBanner(img: hostel.logo),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                      sliver: SliverToBoxAdapter(
                        child: Hostel_info(
                          hostelData: hostel,
                        ),
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      sliver: SliverToBoxAdapter(
                        child: GalleyContainer(),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      sliver: SliverToBoxAdapter(
                        child: DescriptionContainer(
                          description: value.hostelDetailData.description,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      sliver: SliverToBoxAdapter(
                        child: HostelFeatures(
                          hostelFeatures: value.hostelFeatures,
                        ),
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      sliver: SliverToBoxAdapter(
                        child: MapContainer(),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      sliver: SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Comments and Reviews",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.blockSizeVertical! * 2.2,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight! * 0.03,
                              ),
                              CommentHostel(
                                slug: hostel.slug,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
