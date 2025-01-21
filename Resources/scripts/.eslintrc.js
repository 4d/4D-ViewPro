module.exports = {
  "env": {
    "browser": true,
    "commonjs": true,
    "es2021": true,
    "node": false
  },
  "parserOptions": {
    "ecmaVersion": 12
  },
  "rules": {
    "keyword-spacing": "error",
    "no-alert": "error",
    "no-array-constructor": "error",
    "no-caller": "error",
    "no-catch-shadow": "error",
    "no-eval": "error",
    "no-iterator": "error",
    "no-multi-spaces": "error",
    "no-multi-str": "error",
    "no-native-reassign": "error",
    "no-nested-ternary": "error", // unreadable code
    "no-new": "error",
    "no-new-func": "error",
    "no-new-object": "error",
    "no-new-wrappers": "error",
    "no-octal-escape": "error",
    "no-proto": "error",
    "no-script-url": "error",
    "no-sequences": "error",
    "no-trailing-spaces": "error",
    "no-unused-expressions": "error",
    "no-useless-concat": "error",
    "no-var": "error",
    "prefer-const": "error",
    "semi": "error",
    "semi-spacing": [ "error", { after: true, before: false } ],
    "space-before-blocks": "error",
    "space-before-function-paren": "off",
    "space-infix-ops": "error",
    "switch-colon-spacing": "error",
  }
};