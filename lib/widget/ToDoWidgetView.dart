import 'package:flutter/material.dart';
import 'package:flutterapp/utils/ConstantUtils.dart';

class ToDoWidgetView extends StatelessWidget {
  ToDoWidgetView({
    Key key,
    this.title,
    this.sub1,
    this.sub2,
    this.delete,
    this.trailing,
    this.status,
  }) : super(key: key);

  final String title;
  final String sub1;
  final String sub2;
  final Widget delete;
  final Widget trailing;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(ConstantUtils.commonPadding),
        child: Row(children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: ConstantUtils.largeFontSize),
                ), //Text

                const Padding(padding: EdgeInsets.only(bottom: 5.0)),

                Text(
                  '$sub1 · $sub2',
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                      fontSize: ConstantUtils.normalFontSize),
                ),

                const Padding(padding: EdgeInsets.only(bottom: 5.0)),

                Padding(
                    padding:
                        EdgeInsets.only(right: ConstantUtils.commonPadding),
                    child: status != null
                        ? Text(
                            '$status',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontStyle: FontStyle.italic,
                                color: Colors.blueGrey,
                                fontSize: ConstantUtils.normalFontSize),
                          ) //CheckboxListTile
                        : Container(
                            height: 0,
                          )), //Text
              ],
            ), //Column
          ),
          delete,
          trailing,
        ]));
  } //build()

}
