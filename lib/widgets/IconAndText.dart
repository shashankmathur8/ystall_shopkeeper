import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/widgets/bigtext.dart';

import '../components/default_button.dart';

class iconandText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const iconandText({Key? key, 
     required this.icon, required this.text, 
      required this.iconColor})
      : super(key: key);

  Widget _buildPopupDialog(BuildContext context,IconData icon) {
    if(icon.toString()=="IconData(U+0F00D)"){
      return new AlertDialog(
        title:  Text("Edit"),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello"),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }
    else if(icon.toString()=="IconData(U+0E1BB)"){
      return AlertDialog(
        title:  Text("Confirm Delete"),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello"),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
          new FlatButton(
            onPressed: () {
              //Todo remove from list
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Accept'),
          )
        ],
      );
    }else if(icon.toString()=="IconData(U+0E662)"){
  return new AlertDialog(
    title:  Text("Time"),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
    }else if(icon.toString()=="IconData(U+0E4D6)"){
      return new AlertDialog(
        title:  Text("Add"),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildForm(),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }else if(icon.toString()=="IconData(U+0E3AB)"){
      return new AlertDialog(
        title:  Text("SetRange"),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello"),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }
    return new AlertDialog(
      title:  Text(icon.toString()),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: Icon(icon,color: iconColor,),onPressed: ()=>{
        showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context,icon),)

        },),

        bigText(stringText: text,size: 10,color: Colors.black54,)
      ],
    );
  }

  Widget buildForm() {
    return Container(
      child: Column(
        children: [
          TextField(),
          TextField(),
          TextField(),
          TextField(),
          DefaultButton(
            text: "Continue",
            press: () {
              //TODO stuff

            },
          )
        ],
      ),
    );
  }
}
