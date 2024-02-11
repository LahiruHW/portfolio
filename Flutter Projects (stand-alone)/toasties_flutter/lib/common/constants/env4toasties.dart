import 'package:envied/envied.dart';

part 'env4toasties.g.dart';

// to generate the .env.g.dart file again, run the following command:
// dart run build_runner clean
// dart run build_runner build --delete-conflicting-outputs

@Envied(path: '.env')
abstract class ToastiesEnv{

  @EnviedField(varName: 'GEMINI_API_KEY')
  static String geminiApiKey = _ToastiesEnv.geminiApiKey;
  
  @EnviedField(varName: 'NEWS_API_KEY')
  static String newsApiKey = _ToastiesEnv.newsApiKey;

}
