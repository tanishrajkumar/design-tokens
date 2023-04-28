delete require.cache;
const utils = require("./build-utils");
const StyleDictionary = require("style-dictionary-utils");

StyleDictionary.registerTransform(utils.boxShadowCss);
StyleDictionary.registerFileHeader(utils.customFileHeader);

const scssFileConfig = utils.getPlatformSpecificFiles({
  source: "tokens",
  platform: "scss",
  format: "scss/variables",
});

const trasnformsList = [
  "attribute/cti",
  "name/cti/kebab",
  "time/seconds",
  "content/icon",
  "size/rem",
  "color/css",
  "fontWeight/number",
  "fontFamily/css",
  "font/css",
  "shadow/css",
  "border/css",
  "cubicBezier/css",
  "boxShadow/css",
];

const config = {
  source: ["tokens/**/*.json"],
  platforms: {
    web: {
      transforms: trasnformsList,
      buildPath: "build/",
      files: scssFileConfig,
    },
  },
};

const StyleDictionaryExtended = StyleDictionary.extend(config);
StyleDictionaryExtended.buildAllPlatforms();
utils.createRootIndex();
