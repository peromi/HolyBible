import 'dart:convert';

import 'package:bible/models/book.dart';
import 'package:bible/ui/chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class Books extends StatefulWidget {


  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<dynamic> bible = [];
  List<Book> books = [];
  String version = "kjv";
  @override
  void initState() {
    super.initState();
    getData();
    getBooks();
  }

  void getData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/t_kjv.json")
        .then((value) {
      final result = jsonDecode(value);
      print(result['resultset']['row']);
      setState(() {
        bible = result['resultset']['row'];
      });
    });
  }

  void getBooks() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/key_english.json")
        .then((value) {
      final result = jsonDecode(value);
      print(result['resultset']['keys']);
      List<Book> listtomap = (result['resultset']['keys'] as List).map((e) => Book.fromMap(e)).toList();
      setState(() {
        books = listtomap;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Books",style: GoogleFonts.raleway(fontSize:26,color: Colors.purple.shade900, fontWeight: FontWeight.w700),),
        actions: [
          TextButton(onPressed: (){
            showDialog<void>(
                context: context,
                barrierDismissible: false,
                // false = user must tap button, true = tap outside dialog
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('Choose Version'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                    content: DropdownButtonFormField(
                      icon: Icon(AntDesign.down,size: 18,),
                      decoration: InputDecoration(
                        hintText: "Select Bible version",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1)
                        )
                      ),
                      onChanged: (value) {
                        setState(() {
                          version = value.toString();
                        });
                        print(value);
                      },
                      items: [
                        DropdownMenuItem(
                          value: "kjv",
                          child: Text("King James Version"),
                        ),
                        DropdownMenuItem(
                          value: "asv",
                          child: Text("American Standard Version"),
                        ),
                        DropdownMenuItem(
                          value: "bbe",
                          child: Text("Bible in Basic English"),
                        ),
                        DropdownMenuItem(
                          value: "web",
                          child: Text("World English Bible"),
                        ),
                        DropdownMenuItem(
                          value: "ylt",
                          child: Text("Young's Literal Translation"),
                        ),

                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OKAY', style: TextStyle(color: Colors.purple.shade900),),
                        onPressed: () {
                          Navigator.of(dialogContext)
                              .pop(); // Dismiss alert dialog
                        },
                      ),
                    ],
                  );
                },
              );
            }, child: Text("${version}".toUpperCase(), style: TextStyle(color: Colors.purple.shade900),),),
          IconButton(onPressed: (){

          }, icon: Icon(Feather.search,color: Colors.purple.shade900,))
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 120),
            itemCount: books.length,
            itemBuilder: (context, index) => ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chapters(book: books[index], version: version,),));
              },
              title: Text("${books[index].title}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,color: Colors.purple.shade900),),
              subtitle: books[index].number_of_chapters > 1 ? Text("${books[index].number_of_chapters} chapters"):Text("${books[index].number_of_chapters} chapter"),
              trailing: Text("${books[index].testament}"),
            ),
          ),


        ],
      ),
    );
  }
}
