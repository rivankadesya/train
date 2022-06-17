import 'package:flutter/material.dart';
import 'package:respo/detail_character.dart';
import 'package:respo/genshin_data_source.dart';

class ListCharacter extends StatefulWidget {
  const ListCharacter({Key? key}) : super(key: key);

  @override
  _ListCharacterState createState() => _ListCharacterState();
}

class _ListCharacterState extends State<ListCharacter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries Detail"),
      ),
      body: _buildListCharacter(),
    );
  }

  Widget _buildListCharacter() {
    return Container(
      child: FutureBuilder(
        future: GenshinDataSource.instance.loadCharacterList(),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            return _buildSuccessSection(snapshot.data);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<dynamic> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCharacter("${data[index]}");
      },
    );
  }

  Widget _buildItemCharacter(String value) {
    return InkWell(
      onTap: () {
        print("${value} clicked!");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailCharacter(name: value);
        }));
      },
      child: Container(
        child: Row(
          children: [
            Image.network('https://api.genshin.dev/characters/${value}/icon'),
            Text(value),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }
}
