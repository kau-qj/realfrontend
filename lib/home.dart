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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0.0,
        toolbarHeight: screenHeight * 0.13,
        title: Padding(
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
      body: SafeArea(
        child: Column(
          children: [
            // CarouselSlider 부분
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  sliderWidget(),
                  sliderIndicator(),
                ],
              ),
            ),
            SizedBox(height: 20),
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
                                      EdgeInsets.fromLTRB(20.0, 15.0, 8.0, 1.0),
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
                              Expanded(
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: apiService.fetchData(),
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

  Widget _buildAdButtonPage(List<dynamic> adsData) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> adButtons = adsData.map((ad) {
      return _buildAdButton(
        'assets/HompageAdButton.svg',
        ad['title'] ?? 'No Title',
        ad['url'] ?? '',
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
              SvgPicture.asset(svgAsset),
              Positioned(
                bottom: 70,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    width: 150,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
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
}