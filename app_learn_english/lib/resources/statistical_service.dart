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
      'Content-Type': 'application/json'} );
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));

      List<dynamic> statisticalsDynamic = responseData['statisticalDtoList'] ?? [];
      List<StatisticalModel> statisticals = statisticalsDynamic.map((statistical) {
        return StatisticalModel(
            userId: statistical['userId'],
            dateCreateDate: DateTime.parse(statistical['dateCreateDate']),
            score: statistical['score']);
      }).toList();
      return StatisticalMasterModel(
          fullname: responseData['fullname'] ?? '',
          process: responseData['process'],
          streak: responseData['streak'],
          currentScore: responseData['currentScore'],
          statisticalDtoList: statisticals);
    } else {
      throw Exception('Cannot load data');
    }
  } catch(exception) {
    print("Statistical Exception:"+exception.toString());
    throw Exception('Cannot load data');
  }
}
Future<StatisticalMasterModel> getStatisticalOfWeekByUserIdAndWeekAgo(int userId, int weekAgo) async {
  String url = baseUrl + '/api/statistical/findStatisticalOfWeekByUserIdAndDay/'+userId.toString()+'/'+weekAgo.toString();
  final http.Client httpClient = http.Client();
  try {
    final response = await httpClient.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json'} );
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)) as List;
      int index = responseData.indexWhere((element) =>
      element['userId'] == CurrentUserState.id);
      final statisticalMaster = responseData[index];
      List<dynamic> statisticalsDynamic = statisticalMaster['statisticalDtoList'] ?? [];
      List<StatisticalModel> statisticals = statisticalsDynamic.map((statistical) {
        return StatisticalModel(
            userId: statistical['userId'],
            dateCreateDate: DateTime.parse(statistical['dateCreateDate']),
            score: statistical['score']);
      }).toList();
      return StatisticalMasterModel(
          fullname: statisticalMaster['fullname'] ?? '',
          process: statisticalMaster['process'],
          streak: statisticalMaster['streak'],
          currentScore: statisticalMaster['currentScore'],
          statisticalDtoList: statisticals);
    } else {
      throw Exception('Cannot load data');
    }
  } catch(exception) {
    print("Statistical Exception:"+exception.toString());
    throw Exception('Cannot load data');
  }
}