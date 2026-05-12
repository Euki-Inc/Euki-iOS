import { ExpoConfig, ConfigContext } from 'expo/config';

export default ({ config }: ConfigContext): ExpoConfig => ({
  ...config,
  name: 'La Piña',
  slug: 'la-pina-app',
  version: '1.0.0',
  scheme: 'lapina',
  orientation: 'portrait',
  runtimeVersion: {
    policy: 'appVersion',
  },
  assetBundlePatterns: ['**/*'],
  plugins: [
    [
      'expo-build-properties',
      {
        ios: {
          useFrameworks: 'static',
          deploymentTarget: '14.0',
        },
        android: {
          minSdkVersion: 24,
          targetSdkVersion: 34,
          compileSdkVersion: 34,
        },
      },
    ],
    'expo-blur',
  ],
});
