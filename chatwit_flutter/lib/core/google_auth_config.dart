const googleAndroidClientId = String.fromEnvironment(
  'GOOGLE_ANDROID_CLIENT_ID',
  defaultValue:
      '900460976564-7rbb86n6e3hd27plgj974gcqeesud9d4.apps.googleusercontent.com',
);
const googleServerClientId = String.fromEnvironment(
  'GOOGLE_SERVER_CLIENT_ID',
  defaultValue:
      '900460976564-ovfjtnuorjeoem1np4olb9avhjn1a908.apps.googleusercontent.com',
);

String? googleSignInConfigurationError;
