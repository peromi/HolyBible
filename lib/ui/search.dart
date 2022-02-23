import 'dart:convert';

import 'package:bible/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBible extends StatefulWidget {
  Book book;
  String version;
  SearchBible({required this.version, required this.book});
  @override
  _SearchBibleState createState() => _SearchBibleState();
}

class _SearchBibleState extends State<SearchBible> {
  bool isLoading = true;
  List<dynamic> bible = [];
  List<Book> books = [];
  List<Book> resultBook = [];
  TextEditingController _searchbiblecontroller = TextEditingController();
  int selectedIndex = 0;
  Book selectedBook = new Book(index: 0, number_of_chapters: 0, testament: '', title: '');
  @override
  void initState() {
    loadcontent();
    super.initState();


  }

  void loadcontent()async{
    Future.delayed(Duration(milliseconds: 600), (){
      getBooks();
      getData();
    });
  }

  void getData() async {

    if(widget.version == "kjv"){


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

    if(widget.version == "bbe"){

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

    if(widget.version == "web"){

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
    if(widget.version == "asv"){

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
    if(widget.version == "ylt"){

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
        isLoading = false;
      });
    });
  }


  @override
  void dispose() {

    _searchbiblecontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: isLoading ? Material(
        color: Colors.purple.shade900,
        child: Center(child: SpinKitCircle(color: Colors.white, size: 50,),),
      ):Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              AntDesign.close,
                              color: Colors.black,
                            )),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _searchbiblecontroller,
                            onChanged: (value) {
                              // resultBook.clear();
                              if (_searchbiblecontroller.text.isEmpty) {
                                setState(() {});
                                return;
                              }

                              // books.forEach((element) {
                              //   if (element.title
                              //       .toLowerCase()
                              //       .contains(value)) {
                              //     resultBook.add(element);
                              //   }
                              // });

                              setState(() {});
                              // if(value.isNotEmpty){
                              //  List<Book> result= books.where((element) => element.title.toLowerCase().contains(value.toLowerCase())).toList();
                              //
                              //   setState(() {
                              //      resultBook = result;
                              //   });
                              //   print(resultBook.length);
                              // }else{
                              //   resultBook = [];
                              // }
                            },
                            autofocus: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 4),
                                hintText: "${widget.book.title}",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(65),
                                    borderSide: BorderSide(
                                        color: Colors.purple.shade900))),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        TextButton(
                          onPressed: () {
                            var search = _searchbiblecontroller.text.trim();

                           print(search);
                           if(search.contains("vs") || search.contains(":") || search.contains("verse")){


                             print(search.indexOf("vs"));
                             print(search.indexOf(":"));
                             print(search.indexOf("verse"));


                             if(search.startsWith("1") || search.startsWith("2") || search.startsWith("3")){
                               var books = search.split(" ");

                                 if(books.length == 5){
                                   var chapter = books[2];
                                   var verse = books[4];
                                   print("SLength 5");
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                 }else if(books.length == 4){
                                   var chapter = books[2];
                                   var verse = 1;
                                   print("SLength 4");
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                 }else if(books.length == 3){
                                   var chapter = books[2];
                                   var verse = 1;
                                   print("SLength 3");
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                 }else if(books.length == 2){
                                   var chapter = 1;
                                   var verse = 1;
                                   print("SLength 2");
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                 }else{
                                   var chapter = 1;
                                   var verse = 1;
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                   print("SLength 1");
                               }
                               print(books.length);
                             }else{
                               var books = search.split(" ");

                                 if(books.length == 5){
                                   print("Length 5");
                                 }else if(books.length == 4){
                                   var chapter = books[1];
                                   var verse = books[3];
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                   print("Length 4");
                                 }else if(books.length == 3){
                                   var chapter = books[1];
                                   var verse = 1;
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                   print("Length 3");
                                 }else if(books.length == 2){
                                   var chapter = books[1];
                                   var verse = 1;
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                   print("Length 2");
                                 }else{
                                   var chapter = 1;
                                   var verse = 1;
                                   print("SChapter:::${chapter}");
                                   print("SVerse:::${verse}");
                                   print("Length 1");
                                 }
                                 print(books.length);
                             }


                           }else{

                             if(search.startsWith("1") || search.startsWith("2") || search.startsWith("3")){
                               var books = search.split(" ");

                               if(books.length == 5){
                                 print("SxLength 5");
                               }else if(books.length == 4){
                                 print("SxLength 4");
                               }else if(books.length == 3){
                                 print("SxLength 3");
                               }else if(books.length == 2){
                                 print("SxLength 2");
                               }else{
                                 print("SxLength 1");
                               }
                               print(books.length);
                             }else{
                               var books = search.split(" ");

                               if(books.length == 5){
                                 print("xLength 5");
                               }else if(books.length == 4){
                                 print("xLength 4");
                               }else if(books.length == 3){
                                 print("xLength 3");
                               }else if(books.length == 2){
                                 print("xLength 2");
                               }else{
                                 print("xLength 1");
                               }
                               print(books.length);
                             }


                           }


                          },
                          child: Text(
                            "Go",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 90,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...books.map((e) =>
                        ListTile(

                      onTap: (){
                        print(e.index);
                        if(!mounted)return;
                        setState(() {
                          selectedBook = e;
                          selectedIndex = e.index;
                          _searchbiblecontroller.text = e.title;
                          _searchbiblecontroller.selection = TextSelection.fromPosition(TextPosition(offset: _searchbiblecontroller.text.length));
                        });
                      },

                          title: RichText(
                            text: TextSpan(
                                text:
                                    "${e.title.substring(0, _searchbiblecontroller.text.length)}",
                                style: GoogleFonts.raleway(fontWeight: FontWeight.w700,fontSize: 18, color: Colors.purple.shade900),
                                children: [
                                  TextSpan(
                                      text:"${e.title.substring(_searchbiblecontroller.text.length)}",
                                  style: GoogleFonts.raleway(color: Colors.black, fontSize:16, fontWeight: FontWeight.normal))
                                ]),
                          ),
                        )
                    ).toList()
                  ],
                ),
              )),

        ],
      ),
    );
  }
}
