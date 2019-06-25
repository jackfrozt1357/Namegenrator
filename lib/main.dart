import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random names Generator',
      theme :ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
 
}



class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();

  get divider => null;

  

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder:  (context, i) {
          if (i.isOdd) return Divider(); 

          final index = i ~/ 2; 
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }
 
  Widget _buildRow(WordPair pair) {
    final bool  alreadysaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadysaved?Icons.favorite:Icons.favorite_border,
        color :alreadysaved?Colors.red:Colors.blue,
      ),
      onTap: (){
        setState(() {
          if(alreadysaved)
          {
            _saved.remove(pair);
          }
          else{
            _saved.add(pair);
          }
        });
      },
    );
  }
  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>
      (builder :(BuildContext context){
        final Iterable<ListTile> tiles =_saved.map(
          (WordPair pair)
          {
            return ListTile(
              title :Text(
                pair.asPascalCase,
                style : _biggerFont,
              ),
            );
          },

        );
        final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();

          return Scaffold(
              appBar: AppBar(
                title :Text('Favourite'),
              ),
              body: ListView(children: divided,),
          );

      })
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list),onPressed: _pushSaved,),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

}


class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}