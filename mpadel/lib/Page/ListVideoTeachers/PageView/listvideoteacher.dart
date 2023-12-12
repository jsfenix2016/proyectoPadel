import 'package:Klasspadel/Common/Utils/util.dart';
import 'package:Klasspadel/Common/decoder_custom.dart';
import 'package:Klasspadel/Models/videobd.dart';
import 'package:Klasspadel/Page/Home/Pageview/Widgets/CellTeachers/cellteacher.dart';
import 'package:Klasspadel/Page/ListVideoTeachers/Controller/listVideoTeacherController.dart';
import 'package:Klasspadel/Page/video_edit_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListVideoTeacher extends StatefulWidget {
  const ListVideoTeacher({super.key});

  @override
  State<ListVideoTeacher> createState() => _ListVideoTeacherState();
}

class _ListVideoTeacherState extends State<ListVideoTeacher> {
  final ListVideoTeacherController listVideoVC =
      Get.put(ListVideoTeacherController());
  Future<List<VideoBD>> getListVideo() async {
    return await listVideoVC.getAllMyVideos();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis videos para revisar'),
        elevation: 0,
        backgroundColor: Colors.black26,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: decorationCustom(),
        child: FutureBuilder(
          future: getListVideo(),
          builder: (context, state) {
            if (state.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: state.data?.length,
                  itemBuilder: (context, i) {
                    var item = state.data![i];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoEditPlayerScreen(
                              item: item,
                            ),
                          ),
                        );
                      },
                      child: CellTeacher(
                        item: item,
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            }
          },
        ),
      ),
    );
  }
}
