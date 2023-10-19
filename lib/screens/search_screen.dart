import 'package:emulatorapp/models/hostel.dart';
import 'package:emulatorapp/providers/hostel_provider.dart';
import 'package:emulatorapp/screens/search_form.dart';
import 'package:emulatorapp/widgets/search_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search-screen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool search = false;

  final TextEditingController _searchController = TextEditingController();
  List<HostelModel> searchHostelList = [];
  List<HostelModel> allHostel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        allHostel = Provider.of<HostelProvider>(context, listen: false)
            .featuredHostelList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/home-screen");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamed(context, "/home-screen"),
          ),
          title: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                final suggestions = allHostel.where((address) {
                  final city = address.city.toLowerCase();
                  final searchInput = query.toLowerCase();
                  return city.contains(searchInput);
                }).toList();
                setState(() => searchHostelList = suggestions);
              },
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15.0),
                hintText: "Search hostel by location",
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSlidingBottomSheet(
                  context,
                  builder: (context) => SlidingSheetDialog(
                    avoidStatusBar: true,
                    cornerRadius: 18,
                    snapSpec: const SnapSpec(
                      initialSnap: 0.8,
                      snappings: [0.8, 0.9],
                    ),
                    builder: (context, state) {
                      return Material(
                        child: SearchForm(),
                      );
                    },
                  ),
                );
              },
              icon: const FaIcon(
                FontAwesomeIcons.sliders,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        ),
        body: _searchController.text.isNotEmpty && searchHostelList.isEmpty
            ? const Center(child: Text("No Result found"))
            : ListView.builder(
                itemCount: _searchController.text.isNotEmpty
                    ? searchHostelList.length
                    : allHostel.length,
                itemBuilder: (context, index) => SearchbarItem(
                  _searchController.text.isNotEmpty
                      ? searchHostelList[index]
                      : allHostel[index],
                  // favHostel edit now
                ),
              ),
      ),
    );
  }
}
