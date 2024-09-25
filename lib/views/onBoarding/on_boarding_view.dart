import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taskey_app/components/custom_text.dart';
import 'package:taskey_app/utils/constants.dart';
import 'package:taskey_app/views/Home/home_view.dart';
import 'package:taskey_app/views/onBoarding/on_boarding_view_model.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: onboardingPages.length,
              itemBuilder: (context, index) {
                final page = onboardingPages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            // Central image (person) with opacity animation
                            Align(
                              alignment: Alignment.center,
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 600),
                                opacity: currentPage == 0 ? 0 : 1,
                                child: Image.asset(
                                  page.mainImage,
                                  width: currentPage == 0
                                      ? 0
                                      : currentPage == 1
                                          ? 180
                                          : 200,
                                  height: currentPage == 0
                                      ? 0
                                      : currentPage == 1
                                          ? 180
                                          : 200,
                                ),
                              ),
                            ),
                            // Floating avatars or elements with animated positioning
                            ...page.floatingImages.asMap().entries.map((entry) {
                              int i = entry.key;
                              String floatingImage = entry.value;

                              // Use AnimatedPositioned for each floating image
                              return AnimatedPositioned(
                                duration: Duration(milliseconds: 600),
                                top: currentPage == 0
                                    ? i == 0
                                        ? 50
                                        : (i == 1 ? 200 : 180)
                                    : i == 0
                                        ? 50
                                        : (i == 1 ? 80 : 150),
                                left: currentPage == 0
                                    ? i == 0
                                        ? 200
                                        : (i == 1 ? 240 : 30)
                                    : i == 0
                                        ? 30
                                        : (i == 1 ? 200 : 60),
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 600),
                                  opacity: 1,
                                  child: Image.asset(
                                    floatingImage,
                                    width: currentPage == 0 ? 80 : 100,
                                    height: currentPage == 0 ? 80 : 100,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

                      // Title and Subtitle
                      CustomText(
                        text: page.title,
                        color: Color(themeColor),
                        fontSize: 30,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 20),
                      if (index == 0)
                        getFormattedSubtitle(
                            page.subtitle, "space", Color(themeColor))
                      else if (index == 1)
                        getFormattedSubtitle(
                            page.subtitle, "Structured", Color(themeColor))
                      else if (index == 2)
                        getFormattedSubtitle(
                            page.subtitle, "Task", Color(themeColor)),

                      const SizedBox(height: 20),

                      // Pagination Dots
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                onboardingPages.length,
                (dotIndex) => buildDot(dotIndex, context),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip TextButton
              TextButton(
                onPressed: () {
                  Get.to(HomeView());

                  // Handle Skip action
                },
                child: CustomText(
                  text: currentPage < 1 ? 'Skip' : 'Continue',
                  color: Color(themeColor),
                  fontSize: 18,
                ),
              ),

              // Custom Button with Icon
              GestureDetector(
                onTap: () {
                  if (currentPage < onboardingPages.length - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  } else {
                    Get.to(HomeView());
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                  child: Container(
                    width: 70,
                    height: 70,
                    color: Color(themeColor),
                    child: Icon(Icons.arrow_forward,
                        color: Colors.white, size: 24),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Build each dot for pagination
  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: 8),
      height: 10,
      width: currentPage == index ? 30 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(themeColor) : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
