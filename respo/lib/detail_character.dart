import 'package:flutter/material.dart';
import 'package:respo/detail_character_model.dart';

import 'genshin_data_source.dart';

class DetailCharacter extends StatefulWidget {
  final String name;

  const DetailCharacter({Key? key, required this.name}) : super(key: key);

  @override
  _DetailCharacterState createState() => _DetailCharacterState();
}

class _DetailCharacterState extends State<DetailCharacter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Character"),
      ),
      body: _buildDetailCharacter(),
    );
  }

  Widget _buildDetailCharacter() {
    return ListView(
      children: [

        FutureBuilder(
          future: GenshinDataSource.instance.loadDetailCharacter(widget.name),
          builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
          ) {
            if (snapshot.hasError) {
              return _buildErrorSection();
            }
            if (snapshot.hasData) {
              CharacterDetailModel data = CharacterDetailModel.fromJson(snapshot.data);
              return _buildSuccessSection(data);
            }
            return _buildLoadingSection();
          },
        ),
      ],
    );
  }

  Widget _buildSuccessSection(CharacterDetailModel data){
    return Column(
      children: [
        Image.network(
            "https://api.genshin.dev/characters/${widget.name}/gacha-splash"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://api.genshin.dev/nations/${data.nation}/icon".toLowerCase(), width: 20),
            Image.network("https://api.genshin.dev/elements/${data.vision}/icon".toLowerCase(), width: 20),
            Text(widget.name, style: TextStyle(fontSize: 50)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${data.rarity} stars"),
            Text("${data.affiliation}")
          ],
        ),
        Text("${data.description}"),
        Row(
          children: [
            Image.network("https://api.genshin.dev/characters/${widget.name}/talent-na"),
            Column(
              children: [
                Text("${data.skillTalents?[0].name}"),
                Text("${data.skillTalents?[0].description}"),
              ],
            )
          ],
        ),
        Row(
          children: [
            Image.network("https://api.genshin.dev/characters/${widget.name}/talent-skill"),
            Column(
              children: [
                Text("${data.skillTalents?[1].name}"),
                Text("${data.skillTalents?[1].description}"),
              ],
            )
          ],
        ),
        Row(
          children: [
            Image.network("https://api.genshin.dev/characters/${widget.name}/talent-burst"),
            Column(
              children: [
                Text("${data.skillTalents?[1].name}"),
                Text("${data.skillTalents?[1].description}"),
              ],
            )
          ],
        )

      ],
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
