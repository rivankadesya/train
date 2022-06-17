import 'package:flutter/material.dart';
import 'package:respo/detail_character.dart';
import 'package:respo/genshin_data_source.dart';
class ListWeapon extends StatefulWidget {
  const ListWeapon({Key? key}) : super(key: key);

  @override
  State<ListWeapon> createState() => _ListWeaponState();
}
class _ListWeaponState extends State<ListWeapon> {
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
        future: GenshinDataSource.instance.loadWeaponList(),
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
        return _buildItemWeapon("${data[index]}");
      },
    );
  }

  Widget _buildItemWeapon(String value) {
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
            Image.network('https://api.genshin.dev/weapons/${value}/icon',height: 100,width: 100,),
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
