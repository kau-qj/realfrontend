import 'package:flutter/material.dart';
import 'package:qj_projec/button/hompage_ad_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:qj_projec/button/x_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:qj_projec/httpApi/api_hompage.dart';

class MyHompage extends StatefulWidget {
  const MyHompage({super.key});

  @override
  State<MyHompage> createState() => _MyHompageState();
}

class _MyHompageState extends State<MyHompage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List imageList = [
    'assets/HompageAd.png',
    'assets/HompageAd2.png',
    'assets/image 11.png',
  ];

  final ApiService apiService = ApiService(); //api 연결

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0.0,
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SvgPicture.asset(
                  'assets/QJLog.svg',
                  height: 71,
                  width: 71,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 1),
                child: SvgPicture.asset(
                  'assets/HompageTopBar.svg',
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        sliderWidget(),
                        sliderIndicator(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: SizedBox(
                        height: 520,
                        width: 420,
                        child: InnerShadow(
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(2, 5),
                              )
                            ],
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(37),
                                  topRight: Radius.circular(37),
                                ),
                                color: Color.fromARGB(255, 255, 255, 255),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 10,
                                    offset: const Offset(2, 5),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(37),
                                        topRight: Radius.circular(37),
                                      ),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 10,
                                          offset: const Offset(2, 5),
                                        ),
                                      ],
                                    ),
                                    child: PageView.builder(
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return _buildAdButtonPage(context);
                                        }),
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(2.5),
                                      child: Text(
                                        "채용공고",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: SvgPicture.asset(
                                          'assets/HompageSideL.svg'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: SvgPicture.asset(
                                          'assets/HompageSideR.svg'),
                                    ),
                                  ),
                                  FutureBuilder<Map<String, dynamic>>(
                                    future: apiService.fetchData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!['result'] == null) {
                                        return Text('No data fetched from API.');
                                      } else {
                                        // API로부터 받아온 데이터를 저장
                                        List result = snapshot.data!['result'];

                                        // 각 아이템에서 'title'만 추출
                                        List<String> titles = result.map((item) => item['title'] as String).toList();

                                        return ListView.builder(
                                          itemCount: titles.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(titles[index]),
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: imageList.map(
        (imgLink) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image(fit: BoxFit.fill, image: AssetImage(imgLink)),
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12,
              height: 12,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

Widget _buildAdButtonPage(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: _buildAdButton(
              context,
              'assets/HompageAdButton.svg',
              HomepageToAd(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: _buildAdButton(
              context,
              'assets/HompageAdButton.svg',
              ToAdTopL(),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _buildAdButton(
              context,
              'assets/HompageAdButton.svg',
              ToAdBottomR(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _buildAdButton(
              context,
              'assets/HompageAdButton.svg',
              ToAdBottomL(),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildAdButton(
    BuildContext context, String svgAsset, Widget targetPage) {
  return Padding(
    padding: const EdgeInsets.only(left: 1.0),
    child: DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 25.0,
          spreadRadius: 0.0,
          offset: const Offset(0.0, 0.2),
        ),
      ]),
      child: HompageAdButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => targetPage,
            ),
          );
        },
        svgAsset: svgAsset,
      ),
    ),
  );
}

class HomepageToAd extends StatelessWidget {
  const HomepageToAd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0.0,
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SvgPicture.asset(
                  'assets/QJLog.svg',
                  height: 71,
                  width: 71,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 1,
                ),
                child: SvgPicture.asset(
                  'assets/HompageTopBar.svg',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 800,
          width: 420,
          child: InnerShadow(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(37),
                  topRight: Radius.circular(37),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  XButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    svgAsset: 'assets/XButton.svg',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToAdTopL extends StatelessWidget {
  const ToAdTopL({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0.0,
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SvgPicture.asset(
                  'assets/QJLog.svg',
                  height: 71,
                  width: 71,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 1),
                child: SvgPicture.asset(
                  'assets/HompageTopBar.svg',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 800,
          width: 420,
          child: InnerShadow(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(37),
                  topRight: Radius.circular(37),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  XButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    svgAsset: 'assets/XButton.svg',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToAdBottomR extends StatelessWidget {
  const ToAdBottomR({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0.0,
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SvgPicture.asset(
                  'assets/QJLog.svg',
                  height: 71,
                  width: 71,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 1),
                child: SvgPicture.asset(
                  'assets/HompageTopBar.svg',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 800,
          width: 420,
          child: InnerShadow(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(37),
                  topRight: Radius.circular(37),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  XButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    svgAsset: 'assets/XButton.svg',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToAdBottomL extends StatelessWidget {
  const ToAdBottomL({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0.0,
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SvgPicture.asset(
                  'assets/QJLog.svg',
                  height: 71,
                  width: 71,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 1),
                child: SvgPicture.asset(
                  'assets/HompageTopBar.svg',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 800,
          width: 420,
          child: InnerShadow(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(37),
                  topRight: Radius.circular(37),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  XButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    svgAsset: 'assets/XButton.svg',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}