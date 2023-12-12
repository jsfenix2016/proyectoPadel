import 'package:flutter/material.dart';

class VideoListView extends StatelessWidget {
  final List<String> videos;

  const VideoListView({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.amber,
                  width: 200,
                  height: 200,
                  child: Text(videos[index]),
                );
              },
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  height: 200,
                  child: Text(videos[index]),
                );
              },
            ),
          ),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
            ],
            currentIndex: 0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // IconButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => VideoTableListView(videos: videos),
              //       ),
              //     );
              //   },
              //   icon: const Icon(Icons.list),
              // ),

              FloatingActionButton(
                key: Key("camera"),
                onPressed: () {
                  // TODO: Implementar la funcionalidad para grabar un video.
                },
                child: const Icon(Icons.videocam),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VideoTableListView extends StatelessWidget {
  final List<String> videos;

  const VideoTableListView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text('Title')),
          DataColumn(label: Text('Description')),
        ],
        rows: videos
            .map((video) => DataRow(
                  cells: [
                    DataCell(Text(video)),
                    DataCell(Text('Video Description')),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
