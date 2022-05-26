import 'package:app_learn_english/models/statistical_master_model.dart';
import 'package:app_learn_english/models/statistical_model.dart';
import '../states/current_user_state.dart';
import '../utils/constants/Cons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_learn_english/utils/constants/Cons.dart';

Future<StatisticalMasterModel> getStatisticalOfWeek(int userId) async {
  String url = baseUrl + '/api/statistical/getStatisticalOfWeekByUserId/'+userId.toString();
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': CurrentUserState.token} );
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));

      List<dynamic> statisticalsDynamic = responseData['statisticalDtoList'] ?? [];
      List<StatisticalModel> statisticals = statisticalsDynamic.map((statistical) {
        return StatisticalModel(
            userId: statistical['userId'],
            dateCreateDate: DateTime.parse(statistical['dateCreateDate']),
            score: statistical['score']);
      }).toList();
      return StatisticalMasterModel(fullname: responseData['fullname'] ?? '',
          process: responseData['process'], streak: responseData['streak'], statisticalDtoList: statisticals);
      // final StatisticalMasterModel statisticalMasterModel = responseData.map((e) {
      //
      //
      //
      // });
      //
      // return statisticalMasterModel;

     /* final List<StatisticalModel> statisticals = responseData.map((statistical) {
          return StatisticalModel(
              userId: statistical['userId'],
              dateCreateDate: DateTime.parse(statistical['dateCreateDate']),
              score: statistical['score']);
        }).toList();
      return statisticals;*/
    } else {
      throw Exception('Cannot load data');
    }
  } catch(exception) {
    print("Statistical Exception:"+exception.toString());
    throw Exception('Cannot load data');
  }
}