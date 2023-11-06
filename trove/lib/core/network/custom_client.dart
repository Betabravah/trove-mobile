import 'package:http/http.dart' as http;

typedef KeyValue = Map<String, dynamic>;
typedef Headers = Map<String, String>;

class CustomClient {
  final http.Client client;

  String baseUrl;
  String? _authToken;

  set authToken(String token) => _authToken = token;

  CustomClient(this.client, {required this.baseUrl});

  Future<http.Response> get(String relativeUrl,
      {KeyValue? queryParams, Headers headers = const {}}) async {
    Headers headersWithAuth = {
      ...headers,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return client.get(
        Uri.parse('$baseUrl$relativeUrl').replace(queryParameters: queryParams),
        headers: headersWithAuth);
  }

  Future<http.Response> post(String relativeUrl,
      {required KeyValue body, Headers headers = const {}}) async {
    Headers headersWithAuth = {
      ...headers,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return client.post(Uri.parse('$baseUrl$relativeUrl'),
        body: body, headers: headersWithAuth);
  }

  Future<http.Response> put(String relativeUrl,
      {required KeyValue body, Headers headers = const {}}) async {
    Headers headersWithAuth = {
      ...headers,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return client.put(Uri.parse('$baseUrl$relativeUrl'),
        body: body, headers: headersWithAuth);
  }

  Future<http.Response> delete(String relativeUrl,
      {required KeyValue body, Headers headers = const {}}) async {
    Headers headersWithAuth = {
      ...headers,
      if (_authToken != null) 'Authorization': 'Bearer $_authToken'
    };

    return client.delete(Uri.parse('$baseUrl$relativeUrl'),
        body: body, headers: headersWithAuth);
  }
}
