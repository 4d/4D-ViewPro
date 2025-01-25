
module.exports = [{

    languageOptions: {
        ecmaVersion: 12,
        sourceType: "script",
        globals: {
            useToolbar: "writable",
            currentDocument: "writable",
            Commands: "writable",
        },
    },

    rules: {
        // "brace-style": ["warn", "1tbs"],
        "consistent-return": "error",
        "keyword-spacing": "error",
        "no-alert": "error",
        "no-array-constructor": "error",
        "no-caller": "error",
        "no-catch-shadow": "error",
        "no-else-return": "off",
        "no-empty": "warn",
        "no-empty-function": "error",
        "no-eval": "error",
        "no-iterator": "error",
        "no-multi-spaces": "error",
        "no-multi-str": "error",
        "no-native-reassign": "error",
        "no-nested-ternary": "error",
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
        "no-unused-vars": ["warn", { vars: "local", args: "after-used" }], // Ignore unused global variables
        "no-useless-concat": "error",
        "no-var": "error",
        // "object-curly-spacing": [ "error"],
        "prefer-const": "error",
        semi: "error",

        "semi-spacing": ["error", {
            after: true,
            before: false,
        }],

        "space-before-blocks": "error",
        "space-before-function-paren": "off",
        "space-infix-ops": "error",
        "switch-colon-spacing": "error",
    },
}];