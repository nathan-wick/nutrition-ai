module.exports = {
    "env": {
        "browser": true,
        "commonjs": true,
        "es2021": true,
    },
    "extends": [
        `eslint:all`,
        `plugin:@typescript-eslint/recommended`,
    ],
    "parser": `@typescript-eslint/parser`,
    "parserOptions": {
        "ecmaFeatures": {
            "jsx": true,
        },
        "ecmaVersion": `latest`,
        "sourceType": `module`,
    },
    "plugins": [],
    "rules": {
        "comma-dangle": [
            2,
            `always`,
        ],
        "complexity": 0,
        "implicit-arrow-linebreak": 0,
        "max-len": 0,
        "max-lines": 0,
        "max-lines-per-function": 0,
        "max-statements": 0,
        "no-magic-numbers": 0,
        "no-nested-ternary": 0,
        "no-plusplus": 0,
        "no-ternary": 0,
        "no-undef-init": 0,
        "no-undefined": 0,
        "quotes": [
            2,
            `backtick`,
        ],
        "sort-vars": 0,
    },
};
