const fs = require("fs");
const path = require("path");

// Custom File Header
const customFileHeader = {
  name: "myCustomHeader",
  fileHeader: (defaultMessage) => {
    return ["Do not edit directly", "Author - Tanishraj"];
  },
};

// Transformers
const boxShadowCss = {
  name: "boxShadow/css",
  type: "value",
  transitive: true,
  matcher: (token) => {
    return token.type === "boxShadow";
  },
  transformer: ({ value }) => {
    return `${value.x || 0} ${value.y || 0} ${value.blur || 0} ${
      value.spread || 0
    } ${value.color}`;
  },
};

function getPlatformSpecificFiles({ source, platform, format }) {
  const files = fs.readdirSync(source).filter((file) => file.endsWith(".json"));
  const filePaths = files.flatMap((file) => {
    const categories = Object.keys(require(`./${path.join(source, file)}`));
    return categories.map((category) => ({
      format,
      destination: path.join(`${file.split(".")[0]}/${category}.${platform}`),
      options: {
        fileHeader: "myCustomHeader",
      },
      filter: {
        attributes: {
          category,
        },
      },
    }));
  });
  return filePaths;
}

// creating index.scss in root directory
function createRootIndex() {
  const fs = require("fs");
  const path = require("path");
  const ROOT_DIR = "build";
  const ROOT_INDEX_PATH = path.join(ROOT_DIR, "index.scss");

  function readFiles(dir) {
    const files = fs.readdirSync(dir, { withFileTypes: true });
    const imports = [];
    for (const file of files) {
      const filePath = path.join(dir, file.name);
      if (file.isDirectory()) {
        imports.push(...readFiles(filePath));
      } else if (
        file.isFile() &&
        path.extname(filePath) === ".scss" &&
        file.name !== "index.scss"
      ) {
        imports.push(`@import '${filePath.replace(/build\/|\\/g, "")}';`);
      }
    }
    return imports;
  }

  const imports = readFiles(ROOT_DIR);
  imports.unshift(`// Do not edit directly \n// Author - Tanishraj\n`);
  fs.writeFileSync(ROOT_INDEX_PATH, imports.join("\n"));
}

module.exports = {
  boxShadowCss,
  getPlatformSpecificFiles,
  createRootIndex,
  customFileHeader,
};
