import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:qj_projec/httpApi/api_hompage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';

class MyHompage extends StatefulWidget {
  const MyHompage({Key? key}) : super(key: key);

  @override
  State<MyHompage> createState() => _MyHompageState();
}

class _MyHompageState extends State<MyHompage> {
  late Future<Map<String, dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = apiService.fetchHome(); // initState에서 Future를 초기화합니다.
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<String> imageList = [
    'assets/HompageAd.png',
    'assets/HompageAd2.png',
    'assets/image 11.png',
  ];

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar의 내용을 여기에 추가합니다.
            SizedBox(
              height: screenHeight * 0.13, // AppBar의 높이와 동일하게
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: SvgPicture.asset(
                        'assets/QJLog.svg',
                        height: screenHeight * 0.1,
                        width: screenWidth * 0.15,
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
            // CarouselSlider 부분
            SizedBox(
              height: screenHeight * 0.2, // 슬라이더 높이
              child: Stack(
                children: [
                  sliderWidget(),
                  sliderIndicator(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: Center(
                child: SizedBox(
                  height: screenHeight * 0.8,
                  width: screenWidth * 1.0,
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: SvgPicture.asset(
                                'assets/HompageSideL.svg',
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: SvgPicture.asset(
                                'assets/HompageSideR.svg',
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(30.0, 15.0, 8.0, 1.0),
                                  child: Text(
                                    "채용공고",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: Color.fromRGBO(55, 62, 80, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: _future,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data == null ||
                                        snapshot.data!['result'] == null) {
                                      return Text('No data fetched from API.');
                                    } else {
                                      List<dynamic> result =
                                          snapshot.data!['result'];
                                      // _buildAdButtonPage를 호출하여 광고 버튼들을 생성합니다.
                                      return _buildAdButtonPage(result);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdButtonPage(List<dynamic> adsData) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> adButtons = adsData.map((ad) {
      return _buildAdButton(
        'assets/HompageAdButton.svg',
        ad['title'] ?? 'No Title',
        ad['url'] ?? '',
        screenWidth * 0.43,
      );
    }).toList();

    return Wrap(
      alignment: WrapAlignment.center,
      children: adButtons,
    );
  }

  Widget _buildAdButton(
    String svgAsset,
    String title,
    String url,
    double width,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 1.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 25.0,
              spreadRadius: 0.0,
              offset: const Offset(0.0, 0.2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => _launchURL(url),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(svgAsset, width: width),
              Positioned(
                bottom: 60,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    width: width,
                    child: title.contains(']') ? RichText(
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(
                          //fontSize: 12.0,
                          //fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: title.split(']')[0] + ']\n\n\n',  // 줄바꿈 추가
                            style: TextStyle(
                              color: Color.fromRGBO(55, 62, 80, 1),  // 첫 번째 부분의 글자색
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          TextSpan(
                            text: title.split(']')[1],
                            style: TextStyle(
                              color: Color.fromRGBO(55, 62, 80, 1),  // 두 번째 부분의 글자색
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ) : Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (!await launch(url)) {
      print('Could not launch $url');
    }
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
                child: Image.asset(
                  imgLink,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.2,
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