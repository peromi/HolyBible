import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:bible/models/book.dart';
import 'package:bible/ui/search.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Chapters extends StatefulWidget {
  Book book;
  String version;
  Chapters({required this.book, required this.version});
  @override
  _ChaptersState createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  List<dynamic> bible = [];
  List<Book> books = [];
  List<Book> resultBook = [];
  List<int> numberofchapters = [];
  bool refreshChapter = false;
  Book nextbook =
      new Book(title: '', testament: '', number_of_chapters: 0, index: 0);
  Book previousbook =
      new Book(title: '', testament: '', number_of_chapters: 0, index: 0);

  bool isLoading = true;
  int index = 0;
  int indexingchapter = 0;
  int pagecounter = 0;
  int chapternumber = 1;
  String book = "";
  PageController _pageController = PageController(initialPage: 0);

  AutoScrollController _controller = AutoScrollController();

  final global = GlobalKey();

  TextEditingController _searchbiblecontroller = TextEditingController();
  @override
  void initState() {
    super.initState();

    loadcontents();
  }

  void loadcontents() async {
    Future.delayed(Duration(milliseconds: 600), () {
      getData();
      getBooks();
      book = widget.book.title;
    });
  }




  void getData() async {
    if (widget.version == "kjv") {
      await DefaultAssetBundle.of(context)
          .loadString("json/t_kjv.json")
          .then((value) {
        final result = jsonDecode(value);
        print(result['resultset']['row']);
        setState(() {
          bible = result['resultset']['row'];
          isLoading = false;
        });
      });
    }

    if (widget.version == "bbe") {
      await DefaultAssetBundle.of(context)
          .loadString("json/t_bbe.json")
          .then((value) {
        final result = jsonDecode(value);
        print(result['resultset']['row']);
        setState(() {
          bible = result['resultset']['row'];
          isLoading = false;
        });
      });
    }

    if (widget.version == "web") {
      await DefaultAssetBundle.of(context)
          .loadString("json/t_web.json")
          .then((value) {
        final result = jsonDecode(value);
        print(result['resultset']['row']);
        setState(() {
          bible = result['resultset']['row'];
          isLoading = false;
        });
      });
    }
    if (widget.version == "asv") {
      await DefaultAssetBundle.of(context)
          .loadString("json/t_asv.json")
          .then((value) {
        final result = jsonDecode(value);
        print(result['resultset']['row']);
        setState(() {
          bible = result['resultset']['row'];
          isLoading = false;
        });
      });
    }
    if (widget.version == "ylt") {
      await DefaultAssetBundle.of(context)
          .loadString("json/t_ylt.json")
          .then((value) {
        final result = jsonDecode(value);
        print(result['resultset']['row']);
        setState(() {
          bible = result['resultset']['row'];
          isLoading = false;
        });
      });
    }
  }

  void getBooks() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/key_english.json")
        .then((value) {
      final result = jsonDecode(value);
      print(result['resultset']['keys']);
      List<Book> listtomap = (result['resultset']['keys'] as List)
          .map((e) => Book.fromMap(e))
          .toList();
      setState(() {
        books = listtomap;
        widget.book.index == 66 ? '' : books[widget.book.index].title;
      });
    });
  }

  nextBook() {}

  previousBook() {}
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body:   Stack(
                children: [
                  SafeArea(
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        print("trigger");
                        if (details.primaryVelocity.toString().contains("-")) {
                          print("Right");
                          print("CHAPTER ${_pageController.page}");

                          _pageController.nextPage(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.ease);

                          print("NEXT CHApTER ${widget.book.index}");
                          if( _pageController.page! + 1 == widget.book.number_of_chapters.toDouble()){
                            print("GOTO NEXT CHAPTER");
                            setState(() {

                              print("NEXT CHApTER ${widget.book.index}");
                              if(widget.book.index < 66){
                                print("NEXT- ${books[widget.book.index].title}");
                                widget.book = books[widget.book.index];
                                getData();
                                _pageController.jumpToPage(0);

                              }

                            });
                          }
                        } else {
                          print("Left");
                          print("CHAPTER ${_pageController.page}");

                          _pageController.previousPage(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.ease);


                          if(_pageController.page == 0.0){
                            print("Previous chapter");
                            setState(() {
                              print(widget.book.index);
                              if(widget.book.index != 1){

                                print(books[widget.book.index - 1].title);
                                widget.book = books[widget.book.index - 2];
                                _pageController.jumpToPage(widget.book.number_of_chapters-1);
                                getData();
                              }

                            });

                          }
                        }
                        print(details.primaryVelocity.toString());
                      },
                      child: PageView.builder(
                          controller: _pageController,
                          scrollBehavior: ScrollBehavior(),
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (value) {
                            int index = value;
                            print("PAGER NUMBER: ${index}");
                            if(value + 1 == widget.book.number_of_chapters.toDouble()){
                              print("REACHED THE END...");
                              setState(() {

                                index = 0;


                                chapternumber = widget.book.number_of_chapters;


                              });
                            }else{
                              setState(() {


                                  if(value == 0.0)
                                    {
                                      print("REFRESH POINT::::${value}");
                                      chapternumber =  1;
                                    }else{

                                    if(value + 1 == widget.book.number_of_chapters.toDouble()){
                                      print("Continue POINT::::${value}");
                                      chapternumber = widget.book.number_of_chapters;
                                    }else{

                                      chapternumber = index + 1;
                                    }

                                  }




                              });
                            }

                          },
                          itemCount: widget.book.number_of_chapters,
                          itemBuilder: (context, index) {
                            // bible = result['resultset']['row']
                            int chap  = index + 1;
                            indexingchapter = chap;


                            List<dynamic> bibles = bible
                                .where((element) =>
                                    element['field'][1] == widget.book.index &&
                                    element['field'][2] == chapternumber)
                                .toList();
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding:
                                  EdgeInsets.only(top: 35, left: 12, right: 12),
                              controller: _controller,
                              itemCount: bibles.length,
                              itemBuilder: (context, index) => Padding(
                                key: Key(
                                    "${widget.book.title}${bibles[index]['field'][3]}"),
                                padding: EdgeInsets.only(bottom: 12),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: bibles[index]['field'][3] == 1
                                          ? "${chap} "
                                          : "${bibles[index]['field'][3]} ",
                                      style: GoogleFonts.righteous(
                                          fontSize:
                                              bibles[index]['field'][3] == 1
                                                  ? 120
                                                  : 18,
                                          color: Colors.purple.shade900,
                                          fontWeight: FontWeight.w800)),
                                  TextSpan(
                                      text: "${bibles[index]['field'][4]}",
                                      style: GoogleFonts.raleway(
                                          color: Colors.black, fontSize: 23))
                                ])),
                              ),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                      child: Material(
                    elevation: 12,
                    shadowColor: Colors.black26,
                    color: Colors.purple.shade900,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35)),
                    child: SafeArea(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Feather.chevron_left,
                                  color: Colors.white,
                                )),
                            Expanded(
                                child: MaterialButton(
                                    onPressed: () async {
                                      // await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchBible(
                                      //   version: widget.version,
                                      // ),));
                                      await showCupertinoDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) => Material(
                                            color: Colors.black54,
                                            child: SearchBible(
                                              book: widget.book,
                                              version: widget.version,
                                            )),
                                      ).then((value) {
                                        if (value != null) {
                                          Map<String, dynamic> result = value;

                                          setState(() {
                                            widget.book = result['book'];


                                              chapternumber =
                                                  int.parse(result['chapter']);




                                          });

                                          _pageController.jumpToPage(
                                              chapternumber - 1);
                                        }
                                      });
                                    },
                                    elevation: 0.0,
                                    color: Colors.white24,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(45)),
                                    child: Text(
                                      "${widget.book.title}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ))),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Feather.search,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                  )),

                 isLoading? Positioned.fill(
                    child: Stack(
                      children: [
                        Container(
                           color: Colors.purple.shade900,
                        ),
                         Positioned(
                           top: 0,
                           right: -14,
                             bottom: 0,
                             child: Opacity(
                               opacity: 0.3,
                                 child: Image(image: AssetImage("assets/images/cross.png")))),
                        Material(
                          elevation: 0.0,
                          color: Colors.transparent,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeIn(child: Text("${widget.book.title}", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 38, color: Colors.white),)),
                                Text("Loading...", style: TextStyle(color: Colors.white),),
                                // SpinKitCircle(
                                //   color: Colors.white,
                                //   size: 50,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):SizedBox.shrink()

                ],
              ));
  }
}
