import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proypet/src/app/styles/styles.dart';

final _textstyle = TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold);

Widget buttonPri(_text, _funtion, {bool cargando = false}) {
  return SizedBox(
    width: double.maxFinite,
    child: RaisedButton(
      shape: shape20,
      color: colorMain,
      elevation: 2.0,
      textColor: Colors.white,
      child: cargando
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoActivityIndicator(),
                SizedBox(width: 5),
                Text(_text, style: _textstyle),
              ],
            )
          : Text(_text, style: _textstyle),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      onPressed: !cargando ? _funtion : null,
    ),
  );
}

Widget buttonOutLine(String _text, _funtion, Color _color) {
  return OutlineButton(
    onPressed: _funtion,
    child: Text(
      _text,
      style: _textstyle,
    ),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    color: Colors.black.withOpacity(0.15),
    shape: shape20,
    borderSide: new BorderSide(color: _color),
    highlightedBorderColor: _color,
    textColor: _color,
  );
}

Widget buttonFlat(String _text, _funtion, Color _color) {
  return FlatButton(
    onPressed: _funtion,
    child: new Text(_text, style: _textstyle.copyWith(color: _color)),
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    shape: shape20,
  );
}

Widget buttonModal(String _text, _funtion, Color _color) {
  return FlatButton(
    onPressed: _funtion,
    child: new Text(_text, style: _textstyle.copyWith(color: _color)),
    shape: shape20,
  );
}
