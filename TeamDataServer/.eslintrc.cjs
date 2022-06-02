module.exports = {
  env: {
    es2021: true,
    node: true,
  },
  extends: ['airbnb-base'],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  rules: {
    'linebreak-style': 0,
    'no-console': 0,
    'import/extensions': 'off',
    'object-curly-newline': 'off',
    'no-restricted-syntax': 'off',
    'guard-for-in': 'off',
    'no-plusplus': 'off',
  },
};
