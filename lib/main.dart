import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("AppBar"),
            pinned: true,
            // snap: true /* snap과 floating은 세트*/,
            // floating: true,
            expandedHeight: 250,
            flexibleSpace: Container(
              color: Colors.green,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.red,
              height: 300,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MyPersistentHeaderDelegate(
              child: Container(
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    'SliverPersistentHeader',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              minHeight: 50,
              maxHeight: 500,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal /* 가로로 스크롤 가능*/,
                itemCount: 30 /* 빌드할 자식 위젯을 30개로*/,
                itemBuilder: (context, index) /* 콜백 함수, 각 index에 자식 위젯 빌드 */ {
                  return Container /* 각 index에 높이 50, 색상 파란색 Container 반환 */ (
                    width: 20,
                    color: Colors.yellow[index % 10 * 100],
                  );
                },
              ),
            ),
          ),
          SliverList(
            /* 높이를 동적 계산*/
            delegate: SliverChildBuilderDelegate(
              childCount: 20 /* 빌드할 자식 위젯을 20개로*/,
              (context, index) /* 콜백 함수, 각 index에 자식 위젯 빌드 */ {
                return Container /* 각 index에 높이 50, 색상 파란색 Container 반환 */ (
                  height: 50,
                  color: Colors.blue[(index % 10) * 100],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* 추상클래스 이기 때문에 상속해야 한다.*/
class MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  MyPersistentHeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
}
