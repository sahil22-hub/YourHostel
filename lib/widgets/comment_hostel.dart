import 'package:emulatorapp/constants/constants.dart';
import 'package:emulatorapp/constants/size_config.dart';
import 'package:emulatorapp/models/hostel_detail.dart';
import 'package:emulatorapp/providers/hostel_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class CommentHostel extends StatelessWidget {
  final String slug;
  const CommentHostel({Key? key, required this.slug}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return FutureBuilder(
        future: Provider.of<HostelDetailProvider>(context, listen: false)
            .fetchHostelData(slug),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error Loading Comments");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<HostelDetailProvider>(builder: (context, value, _) {
              return Column(
                children: [
                  ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.hostelDetailData.comments.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: CircleAvatar(
                                  radius: 25,
                                  child: Icon(
                                    Icons.person,
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.hostelDetailData.comments[index]
                                          ["name"],
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 1.8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      value.hostelDetailData.comments[index]
                                          ["commented_at"],
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 1.7,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: ReadMoreText(
                                    value.hostelDetailData.comments[index]
                                        ["comment"],
                                    trimLines: 2,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          SizeConfig.blockSizeVertical! * 1.8,
                                    ),
                                    colorClickableText: Colors.grey,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'See more',
                                    trimExpandedText: 'See less',
                                    textScaleFactor: 1,
                                    lessStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 1.6,
                                        fontWeight: FontWeight.bold),
                                    moreStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            SizeConfig.blockSizeVertical! * 1.6,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(thickness: 0.7)
                          ],
                        );
                      }),
                  CommentBuilder(
                    hostelDetailData: value.hostelDetailData.googleReviews,
                  ),
                ],
              );
            });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class CommentBuilder extends StatelessWidget {
  const CommentBuilder({
    Key? key,
    required this.hostelDetailData,
  }) : super(key: key);

  final List hostelDetailData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: hostelDetailData.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        hostelDetailData[index]["profile_photo_url"]),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            hostelDetailData[index]["author_name"],
                            textScaleFactor: 1,
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical! * 1.8,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              "google",
                              textScaleFactor: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: kSubtitleFontSize,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        hostelDetailData[index]["created_at"],
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.blockSizeVertical! * 1.7,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ReadMoreText(
                      hostelDetailData[index]["review"],
                      trimLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeVertical! * 1.8,
                      ),
                      colorClickableText: Colors.grey,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'See more',
                      trimExpandedText: 'See less',
                      textScaleFactor: 1,
                      lessStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.blockSizeVertical! * 1.6,
                          fontWeight: FontWeight.bold),
                      moreStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.blockSizeVertical! * 1.6,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 0.7)
            ],
          );
        });
  }
}
