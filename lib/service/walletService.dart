// import 'package:dio/dio.dart';
//
// class WalletService {
//   final Dio dio;
//
//   WalletService(this.dio);
//
//   Future<Map<String, dynamic>> createWallet(
//       String securityCode,
//       String confirmSecurityCode,
//       String bankAccount,
//       String token, // Add the token for authorization
//       ) async {
//     final String url = 'https://rideshare.devscape.online/api/v1/wallet';
//     final data = {
//       'securityCode': securityCode,
//       'confirmSecurityCode': confirmSecurityCode,
//       'bankAccount': bankAccount,
//     };
//
//     try {
//       print('Creating wallet...');
//       print('Request URL: $url');
//       print('Request Headers: Authorization: Bearer $token, Content-Type: application/json');
//       print('Request Body: $data');
//
//       final response = await dio.post(
//         url,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token', // Include the authorization token
//             'Content-Type': 'application/json',
//           },
//         ),
//       );
//
//       print('Response data: ${response.data}'); // Print the raw response
//
//       if (response.data is Map<String, dynamic>) {
//         return response.data as Map<String, dynamic>;
//       } else if (response.data is String) {
//         // If the response is a string, log it and throw an exception
//         print('Unexpected string response: ${response.data}');
//         throw Exception('Unexpected string response: ${response.data}');
//       } else {
//         // Handle any other unexpected response types
//         throw Exception('Unexpected response type');
//       }
//     } on DioError catch (e) {
//       if (e.response != null) {
//         print('Error response data: ${e.response!.data}'); // Print error response
//         print('Error status code: ${e.response!.statusCode}'); // Print status code
//         print('Error headers: ${e.response!.headers}'); // Print headers
//         print('Error request options: ${e.response!.requestOptions}'); // Print request options
//
//         // Check if the error response is a string and handle it
//         if (e.response!.data is String) {
//           print('Error: ${e.response!.data}');
//           throw Exception('Error response received as string: ${e.response!.data}');
//         }
//
//         // If it's a map, return it as expected
//         if (e.response!.data is Map<String, dynamic>) {
//           return e.response!.data as Map<String, dynamic>;
//         } else {
//           throw Exception('Failed to create wallet: ${e.response!.data}');
//         }
//       } else {
//         // Handle the case where there is no response data
//         print('Error: No response data');
//         throw Exception('Failed to create wallet: ${e.message}');
//       }
//     } catch (e) {
//       // Catch and handle any other exceptions
//       print('Error: ${e.toString()}');
//       throw Exception('Failed to create wallet: ${e.toString()}');
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:rideshare/model/walletModel.dart';

class WalletService {
  final Dio dio;

  WalletService(this.dio);

  Future<WalletModel> getWallet(String token) async {
    final String url = 'https://rideshare.devscape.online/api/v1/wallet';

    try {
      print('Fetching wallet info...');
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': '*/*',
          },
          validateStatus: (status) {
            return status! < 500; // Handle all statuses less than 500
          },
        ),
      );

      print('Response data: ${response.data}'); // Print the raw response

      if (response.statusCode == 200 || response.statusCode == 202) {
        return WalletModel.fromJson(response.data['body']);
      } else if (response.statusCode == 403) {
        print('Access denied error: ${response.data}');
        throw Exception('Access denied: Invalid or expired token. Please log in again.');
      } else {
        throw Exception('Failed to fetch wallet information');
      }
    } on DioError catch (e) {
      print('Error fetching wallet info: ${e.response?.data}');
      throw Exception('Failed to fetch wallet: ${e.message}');
    } catch (e) {
      print('Error: ${e.toString()}');
      throw Exception('Failed to fetch wallet: ${e.toString()}');
    }
  }
}
