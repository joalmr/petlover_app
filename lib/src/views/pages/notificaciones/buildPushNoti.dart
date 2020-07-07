import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proypet/src/utils/add_msg.dart';
import 'dart:math' as Math;

class BuildPushNoti extends StatelessWidget {
  // const BuildPushNoti({Key key}) : super(key: key);
  final dynamic noti;
  BuildPushNoti({@required this.noti});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Image(
                  image: CachedNetworkImageProvider(noti['pet_picture']),
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    '${noti['message']} ${thxNoti[Math.Random().nextInt(thxNoti.length)]}'),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            child: Image(
              image: CachedNetworkImageProvider(noti[
                  'notification_image']), //TODO: cambiar por la imagen que vendra en el push "notification_image"
              height: 140,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget buildPushNoti(context, noti) {
//   return Container(
//     child: Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//               child: Image(
//                 image: CachedNetworkImageProvider(noti['pet_picture']),
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Expanded(
//                 child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                   '${noti['message']} ${thxNoti[Math.Random().nextInt(thxNoti.length)]}'),
//             )),
//           ],
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         ClipRRect(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           child: Image(
//             image: CachedNetworkImageProvider(noti[
//                 'notification_image']), //TODO: cambiar por la imagen que vendra en el push "notification_image"
//             height: 140,
//             width: double.maxFinite,
//             fit: BoxFit.cover,
//           ),
//         ),
//         Row(
//           // crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             FlatButton(
//               child: Text('Ok'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
