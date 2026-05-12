module.exports = function (api) {
  api.cache(true);
  return {
    presets: [['babel-preset-expo', { jsxImportSource: 'nativewind' }]],
    plugins: [
      'expo-router/babel',
      'react-native-reanimated/plugin',
      [
        'module-resolver',
        {
          alias: {
            '@': './app',
            '@/screens': './app/screens',
            '@/components': './app/components',
            '@/navigation': './app/navigation',
            '@/theme': './app/theme',
            '@/localization': './app/localization',
            '@/services': './app/services',
            '@/hooks': './app/hooks',
            '@/types': './app/types',
            '@/utils': './app/utils',
            '@/assets': './assets',
          },
        },
      ],
    ],
  };
};
