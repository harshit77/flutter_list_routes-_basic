import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main () => runApp( new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Exercise Two',
      theme: new ThemeData(
        primaryColor: Colors.green
      ),
      home: CompanyName()
    );
  }
}
class CompanyName extends StatefulWidget {
  @override
  CompanyNameState createState() => new CompanyNameState(); 
}
class CompanyNameState extends State<CompanyName> {
  final List<WordPair> _suggestions=<WordPair>[];
  final Set<WordPair> _saved= new Set<WordPair>();
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder:(BuildContext context) {
          final Iterable<ListTile> tileItems= _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(pair.asUpperCase),
              );
            }
          );
          final List<Widget> divided= ListTile.divideTiles( context: context,tiles: tileItems).toList();
             return new Scaffold(
          appBar: new AppBar(
            title:new Text('Saved Names')
          ),
          body:new ListView(children:divided )
        );
        }
        )
    );
    }
  @override
  Widget build(BuildContext context){
    return new Scaffold(
     appBar: new AppBar(
       title: Text('Choose Company Name'),
       actions: <Widget>[
         new IconButton(icon: const Icon(Icons.list),onPressed: _pushSaved)
       ],
     ),
      body:_buildSuggestion()
    );
  }
  @override
  Widget _buildSuggestion() {
    return new ListView.builder(
    itemBuilder: (context,i) {
          if(i.isOdd) return Divider();
          final index = i ~/2;
          if(index >= _suggestions.length)
          {
           _suggestions.addAll(generateWordPairs().take(1));
          }
          return _buildRow(_suggestions[index]);
      }
    );
  }
  @override
  Widget _buildRow(WordPair pair){
    final bool _alreadySaved= _saved.contains(pair);
    return new ListTile(
      title: new Text(pair.asUpperCase),
      trailing: new Icon(
        _alreadySaved ?Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null ,
      ),
      onTap: () {
        setState((){
          if(_alreadySaved){
              _saved.remove(pair);
          }
          else{
            _saved.add(pair);
          } 
        });
      }
    );

  }

}