import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/global_reg_data.dart' as globals;
import 'package:image_picker/image_picker.dart';

class ImageReg extends StatefulWidget {
  const ImageReg({Key? key}) : super(key: key);

  @override
  State<ImageReg> createState() => _ImageRegState();
}

class _ImageRegState extends State<ImageReg> {
  final ImagePicker _kitchenPicker = ImagePicker();
  final ImagePicker _roomPicker = ImagePicker();
  final ImagePicker _toiletPicker = ImagePicker();
  final List<XFile>? _kitchenImageFileList = [];
  final List<XFile>? _roomImageFileList = [];
  final List<XFile>? _toiletImageFileList = [];
  final List? kitchen64 = [];
  final List? bedroom64 = [];
  final List? bathroom64 = [];

  // Future<void> uploadImage(imageFileList) async {
  //   for (int i = 0; i < imageFileList!.length; i++) {
  //     File imageFile = File(_kitchenImageFileList![i].path);
  //     var stream = new http.ByteStream(imageFile.openRead());
  //     stream.cast();
  //     var length = await imageFile.length();
  //     var multiPartFile = http.MultipartFile('photo', stream, length);
  //     globals.gallery0.add(multiPartFile);
  //     //print("Kitchen length (global gallery 0): ${globals.gallery0.length}");
  //   }
  // }

  Future<void> BedroomImage(imageFileList) async {
    globals.gallery1.clear();
    globals.image = imageFileList[0];
    for (int i = 0; i < imageFileList!.length; i++) {
      File imageFile = File(imageFileList[i].path);
      //print(imageFile.path);
      var stream = new http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      print('$length');
      var multiPartFile = http.MultipartFile('bedroom', stream, length);
      globals.gallery1.add(multiPartFile);
      print("Bedroom length (global gallery 1): ${globals.gallery1.length}");
    }
  }

  Future<void> KitchenImage(imageFileList) async {
    globals.gallery0.clear();
    for (int i = 0; i < imageFileList!.length; i++) {
      File imageFile = File(imageFileList![i].path);
      var stream = new http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      var multiPartFile = http.MultipartFile('kitchen', stream, length);
      globals.gallery0.add(multiPartFile);
      //print("Kitchen length (global gallery 0): ${globals.gallery0.length}");
    }
  }

  Future<void> BathroomImage(imageFileList) async {
    globals.gallery2.clear();
    for (int i = 0; i < imageFileList!.length; i++) {
      File imageFile = File(imageFileList[i].path);
      var stream = new http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      var multiPartFile = http.MultipartFile('bathroom', stream, length);
      globals.gallery2.add(multiPartFile);
      print("Bathroom length (global galley 2): ${globals.gallery2.length}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: _size.height * 0.8,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    child: const Text(
                      'Upload Kitchen/Dinning Pictures',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 38, 60, 102),
                      ),
                    ),
                    onPressed: () {
                      selectKitchenImages();
                    },
                  ),
                ),
                if (_kitchenImageFileList!.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        globals.gallery0.clear();
                        _kitchenImageFileList!.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 85, 108, 148),
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            _kitchenImageFileList!.isEmpty
                ? const SizedBox(
                    // height: 50.0,
                    )
                : Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: _kitchenImageFileList!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 1.5,
                        ),
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(_kitchenImageFileList![index].path),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    child: const Text(
                      'Upload Bedroom Pictures',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 38, 60, 102),
                      ),
                    ),
                    onPressed: () {
                      selectBedroomImages();
                      //selectImages(_roomImageFileList, _roomPicker);
                    },
                  ),
                ),
                if (_roomImageFileList!.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        globals.gallery1.clear();
                        _roomImageFileList!.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 85, 108, 148),
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            _roomImageFileList!.isEmpty
                ? const SizedBox(
                    // height: 50.0,
                    )
                : Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        itemCount: _roomImageFileList!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                                childAspectRatio: 1.5),
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(_roomImageFileList![index].path),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    child: const Text(
                      'Upload Toilet/Bathroom Pictures',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 38, 60, 102),
                      ),
                    ),
                    onPressed: () {
                      selectBathroomImages();
                      //selectImages(_toiletImageFileList, _toiletPicker);
                    },
                  ),
                ),
                if (_toiletImageFileList!.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        globals.gallery2.clear();
                        _toiletImageFileList!.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 85, 108, 148),
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: _toiletImageFileList!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    return Image.file(
                      File(_toiletImageFileList![index].path),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectKitchenImages() async {
    final List<XFile>? selectedKitchenImages =
        await _kitchenPicker.pickMultiImage();
    if (selectedKitchenImages!.isNotEmpty) {
      _kitchenImageFileList!.addAll(selectedKitchenImages);
      KitchenImage(_kitchenImageFileList);
    }
    setState(() {});
  }

  void selectBedroomImages() async {
    final List<XFile>? selectedBedroomImages =
        await _roomPicker.pickMultiImage();
    if (selectedBedroomImages!.isNotEmpty) {
      _roomImageFileList!.addAll(selectedBedroomImages);
      BedroomImage(_roomImageFileList);
    }
    print('this is bedroom img $_roomImageFileList');

    setState(() {});
  }

  void selectBathroomImages() async {
    final List<XFile>? selectedBathroomImages =
        await _toiletPicker.pickMultiImage();
    if (selectedBathroomImages!.isNotEmpty) {
      _toiletImageFileList!.addAll(selectedBathroomImages);
      BathroomImage(_toiletImageFileList);
    }

    setState(() {});
  }
}
