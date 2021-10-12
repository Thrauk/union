import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const IntroPage());
  }

  static Page page() => const MaterialPage<void>(child: IntroPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(169, 223, 216, 1),
      body: _Intro01(),
    );
  }
}

class _Intro01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Union',
                      style: TextStyle(
                          fontFamily: 'LatoBlack',
                          fontWeight: FontWeight.w900,
                          fontSize: 26
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Image(
                        image: AssetImage(
                            'assets/intro_page/page_1.png'
                        ),
                    ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                            'Find a team and start working\ntogether',
                          style: TextStyle(
                              fontFamily: 'LatoBold',
                              fontWeight: FontWeight.w700,
                              fontSize: 23
                          ),
                        ),
                      ),
                    ),
                )
              ],
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
                color: Color.fromRGBO(18, 18, 18, 1),
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: DotsIndicator(
                          dotsCount: 3,
                          position: 0,
                          decorator: DotsDecorator(
                            spacing: EdgeInsets.all(15),
                            activeColor: Color.fromRGBO(196, 196, 196, 1),
                            color: Color.fromRGBO(196, 196, 196, 0.5),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        onSurface: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        side: BorderSide(width: 2.0, color: const Color.fromRGBO(169, 223, 216, 1)),
                                        minimumSize: Size(double.infinity, double.infinity)

                                      ),

                                      child: Text(
                                        'Skip',
                                        style: TextStyle(
                                          color: const Color.fromRGBO(169, 223, 216, 1),
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color.fromRGBO(169, 223, 216, 1),
                                      onSurface: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      side: BorderSide(width: 2.0, color: const Color.fromRGBO(169, 223, 216, 1)),
                                      minimumSize: Size(double.infinity, double.infinity)
                                    ),
                                    child: Text(
                                        'Next',
                                        style: TextStyle(
                                          color: Color.fromRGBO(18, 18, 18, 1),
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
            ),
        ),
      ],
    );
  }
}
