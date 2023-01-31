import 'package:flutter/material.dart';
import 'package:sign_lang_detect/values/values.dart';

class FrequentlyUsed extends StatefulWidget {
  const FrequentlyUsed({Key? key}) : super(key: key);

  @override
  State<FrequentlyUsed> createState() => _FrequentlyUsedState();
}

class _FrequentlyUsedState extends State<FrequentlyUsed> {

  late TextEditingController _searchController;
  var list_signs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
    list_signs = Values.signs;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (word){
                list_signs = Values.signs.where((sign) => sign["name"].toString().toLowerCase().contains(word.toLowerCase())).toList();
                if(word.isEmpty){
                  list_signs = Values.signs;
                }
                setState(() {});
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                hintText: "eg: Good Morning",
                contentPadding: const EdgeInsets.all(20),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
            ),
          ),
          Container(
            height: screen.height-180,
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: list_signs.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list_signs[index]["name"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              list_signs[index]["synonyms"].join(" | "),
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontStyle: FontStyle.italic
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/signs/${list_signs[index]["image"]}.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        height: 30,
                        width: 30,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}