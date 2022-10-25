class AppConfig {
  
  static const bool https = true;
  static const domainPath = "api-001.emberspec.com";
  static const String baseApiEndpoint = "/api";
  static const String protocol = https ? "https://" : "http://";
  static const String rawBaseUrl = "$protocol$domainPath";
  static const String baseUrl = "$rawBaseUrl$baseApiEndpoint";
}
