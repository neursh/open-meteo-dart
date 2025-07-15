const collectedData = {
  pages: {}
};

// JS implementation of Dart's `_generate_transform.dart` by MathNerd28
// https://github.com/MathNerd28
const replacements = {
  'pm2_5': 'pm2p5',
  'windspeed': 'wind_speed',
  'winddirection': 'wind_direction',
};

const defaultValue = '$default$';

const staticSuffixes = {
  'aggregation': {
    'defaultValue': 'Aggregation.none',
    '_max': 'Aggregation.maximum',
    '_min': 'Aggregation.minimum',
    '_mean': 'Aggregation.mean',
    '_median': 'Aggregation.median',
    '_sum': 'Aggregation.sum',
    '_dominant': 'Aggregation.dominant',
    '_p10': 'Aggregation.p10',
    '_p25': 'Aggregation.p25',
    '_p75': 'Aggregation.p75',
    '_p90': 'Aggregation.p90',
  }
};

const regexSuffixes = {
  'altitude': /\_(\d+)m$/,
  'depth,depthTo': /\_(\d+)_to_(\d+)cm$/,
  'depth': /\_(\d+)cm$/,
  'pressureLevel': /\_(\d+)hPa/,
};

function buildIndex(inputs) {
  const index = {};
  for (const input of inputs) {
    const properties = {};
    const root = computeRoot(input, properties);
    if (!index[root]) {
      index[root] = {};
    }
    index[root][input] = properties;
  }
  return index;
}

function computeRoot(root, properties) {
  for (const [suffixGroupKey, suffixGroupValue] of Object.entries(staticSuffixes)) {
    if (properties.hasOwnProperty(suffixGroupKey)) continue;
    for (const [suffixKey, suffixValue] of Object.entries(suffixGroupValue)) {
      if (!root.endsWith(suffixKey)) continue;
      properties[suffixGroupKey] = suffixValue;
      return computeRoot(root.substring(0, root.length - suffixKey.length), properties);
    }
  }

  for (const [regexSuffixKey, regexSuffixValue] of Object.entries(regexSuffixes)) {
    if (properties.hasOwnProperty(regexSuffixKey)) continue;
    const match = regexSuffixValue.exec(root);
    if (match === null) continue;
    const captures = match.slice(1);
    properties[regexSuffixKey] = `(${captures.join(',')})`;
    return computeRoot(root.substring(0, match.index), properties);
  }

  for (const [replacementKey, replacementValue] of Object.entries(replacements)) {
    root = root.replace(new RegExp(replacementKey, 'g'), replacementValue);
  }
  
  return root;
}

function decodeBuild(index) {
  let decodeOutput = "";
  for (const [titleKey, titleValue] of Object.entries(index)) {
    for (const [childKey, childValue] of Object.entries(titleValue)) {
      if (Object.keys(childValue).length === 0) {
        decodeOutput += `${childKey}(Variable.${childKey},),`;
        continue;
      }
      
      for (const [valueKey, valueValue] of Object.entries(childValue)) {
        const extract = valueValue.replace(/[\(\)]/g, "").split(",");
        if (valueKey === 'depth,depthTo') {
          decodeOutput += `${childKey}(Variable.${titleKey}, depth: ${extract[0]}, depthTo: ${extract[1]},),`;
          continue;
        }
        decodeOutput += `${childKey}(Variable.${titleKey}, ${valueKey}: ${extract[0]},),`;
      }
    }
  }
  return decodeOutput;
}

function analyzeVariableProperties(variables) {
  const usedProperties = new Set();
  
  for (const variable of variables) {
    const properties = {};
    computeRoot(variable, properties);
    
    for (const key of Object.keys(properties)) {
      if (key === 'depth,depthTo') {
        usedProperties.add('depth');
        usedProperties.add('depthTo');
      } else {
        usedProperties.add(key);
      }
    }
  }
  
  return usedProperties;
}

function generateEnumOutput(pageKey, variableType, variables) {
  const suffix = {
    'hourly': 'Hourly',
    'daily': 'Daily',
    'current': 'Current',
    'minutely15': 'Minutely15'
  }[variableType] || variableType;
  
  const enumName = `${pageKey}${suffix}`;
  const variableArray = [...variables];

  const apiTypeMap = {
    'Weather': 'WeatherApi',
    'Historical': 'HistoricalWeatherApi',
    'Ensemble': 'EnsembleApi',
    'Climate': 'ClimateApi',
    'Marine': 'MarineWeatherApi',
    'AirQuality': 'AirQualityApi',
    'Flood': 'FloodApi'
  };

  const timeTypeMap = {
    'hourly': 'Hourly',
    'daily': 'Daily',
    'current': 'Current',
    'minutely15': 'Minutely15'
  };
  
  const apiClass = apiTypeMap[pageKey];
  const timeClass = timeTypeMap[variableType];

  const usedProperties = analyzeVariableProperties(variableArray);
  
  let output = `enum ${enumName} with Parameter<${apiClass}, ${timeClass}> {\n`;
  
  for (const variable of variableArray) {
    const properties = {};
    const root = computeRoot(variable, properties);
  
    const enumValue = variable.replace(/[^a-zA-Z0-9_]/g, '_');
  
    let constructorCall = `Variable.${root}`;
  
    const params = [];
    for (const [key, value] of Object.entries(properties)) {
      if (key === 'depth,depthTo') {
        const extract = value.replace(/[\(\)]/g, "").split(",");
        params.push(`depth: ${extract[0]}`);
        params.push(`depthTo: ${extract[1]}`);
      } else {
        const extract = value.replace(/[\(\)]/g, "").split(",");
        params.push(`${key}: ${extract[0]}`);
      }
    }

    if (params.length === 0) {
      output += `  ${enumValue}(\n    ${constructorCall},\n  ),\n`;
    } else {
      output += `  ${enumValue}(\n    ${constructorCall},\n`;
      for (const param of params) {
        output += `    ${param},\n`;
      }
      output += `  ),\n`;
    }
  }
  
  output += `;\n\n`;

  output += `  @override\n  final Variable variable;\n`;

  const allPossibleProperties = ['altitude', 'depth', 'depthTo', 'pressureLevel', 'aggregation'];
  const dynamicProperties = allPossibleProperties.filter(prop => usedProperties.has(prop));
  
  for (const prop of dynamicProperties) {
    if (prop === 'aggregation') {
      output += `  @override\n  final Aggregation ${prop};\n`;
    } else {
      output += `  @override\n  final int ${prop};\n`;
    }
  }

  output += `  const ${enumName}(\n    this.variable, {\n`;
  
  for (const prop of dynamicProperties) {
    if (prop === 'aggregation') {
      output += `    this.${prop} = Aggregation.none,\n`;
    } else {
      output += `    this.${prop} = 0,\n`;
    }
  }
  
  output += `  });\n\n`;

  output += `  static final Map<int, ${enumName}> hashes =\n      makeHashes(${enumName}.values);\n`;
  
  output += `}\n\n`;
  return output;
}

function fetchResult(variable) {
  return [...variable];
}

function consoleVariable(title, variables, pageKey) {
  if (variables.size > 0) {
    const variableArray = fetchResult(variables);
    console.log(`%c${title}:`, "color: blue");
    console.log(variableArray.join(","));

    if (!collectedData.pages[pageKey]) {
      collectedData.pages[pageKey] = {};
    }
    collectedData.pages[pageKey][title.toLowerCase()] = variableArray;
  }
}

function collectVariables(pageKey) {
  const hourlyVariables = new Set();
  const dailyVariables = new Set();
  const currentVariables = new Set();
  const minutely15Variables = new Set();
  
  setTimeout(() => {
    const variables = document.getElementsByClassName("peer-disabled:cursor-not-allowed peer-disabled:opacity-70 ml-[0.42rem] cursor-pointer truncate py-[0.1rem]");
    for (let i = 0; i < variables.length; i++) {
      const label = variables[i].getAttribute("for");
      if (label.endsWith("hourly")) {
        hourlyVariables.add(label.slice(0, -7));
      }
      if (label.endsWith("daily")) {
        dailyVariables.add(label.slice(0, -6));
      }
      if (label.endsWith("current")) {
        currentVariables.add(label.slice(0, -8));
      }
      if (label.endsWith("minutely_15")) {
        minutely15Variables.add(label.slice(0, -12));
      }
    }
    consoleVariable("Hourly", hourlyVariables, pageKey);
    consoleVariable("Daily", dailyVariables, pageKey);
    consoleVariable("Current", currentVariables, pageKey);
    consoleVariable("Minutely15", minutely15Variables, pageKey);

    console.log(`%cCollected variables for ${pageKey}`, "color: purple; font-weight: bold");
  }, 1000);
}

const docPages = [
  { path: "/en/docs", key: "Weather" },
  { path: "/en/docs/historical-weather-api", key: "Historical" },
  { path: "/en/docs/ensemble-api", key: "Ensemble" },
  { path: "/en/docs/climate-api", key: "Climate" },
  { path: "/en/docs/marine-weather-api", key: "Marine" },
  { path: "/en/docs/air-quality-api", key: "AirQuality" },
  { path: "/en/docs/satellite-radiation-api", key: "Satellite" },
  { path: "/en/docs/flood-api", key: "Flood" }
];

function camelToSnake(str) {
  return str.replace(/([A-Z])/g, '_$1').toLowerCase().replace(/^_/, '');
}

function saveCollectedData() {
  console.log(`%cGenerating Dart enum files...`, "color: red; font-weight: bold; font-size: 16px");

  const generatedFiles = {};
  
  for (const [pageKey, pageData] of Object.entries(collectedData.pages)) {
    const fileName = camelToSnake(pageKey);

    let fileContent = `// Generated Variable Enums for ${pageKey}\n\nimport '../api.dart';\nimport '../apis/weather.dart';\nimport '../weather_api_openmeteo_sdk_generated.dart';\n\n`;

    const timeOrder = ['minutely15', 'current', 'hourly', 'daily'];
    
    for (const variableType of timeOrder) {
      if (pageData[variableType] && pageData[variableType].length > 0) {
        fileContent += generateEnumOutput(pageKey, variableType, pageData[variableType]);
      }
    }
    
    if (fileContent.trim() !== `// Generated Variable Enums for ${pageKey}\n\nimport '../api.dart';\nimport '../apis/weather.dart';\nimport '../weather_api_openmeteo_sdk_generated.dart';`) {
      generatedFiles[`${fileName}.dart`] = fileContent;
    }
  }

  console.log(`%cGenerated Files:`, "color: orange; font-weight: bold; font-size: 16px");
  for (const [fileName, content] of Object.entries(generatedFiles)) {
    console.log(`%c${fileName}:`, "color: purple; font-weight: bold");
    console.log(content);
  }

  createZipFile(generatedFiles);
}

async function createZipFile(files) {
  const script = document.createElement('script');
  script.src = 'https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js';
  document.head.appendChild(script);
  
  script.onload = async () => {
    const zip = new JSZip();
    for (const [fileName, content] of Object.entries(files)) {
      zip.file(fileName, content);
    }

    const zipBlob = await zip.generateAsync({ type: 'blob' });

    const zipUrl = URL.createObjectURL(zipBlob);
    const zipLink = document.createElement('a');
    zipLink.href = zipUrl;
    zipLink.download = '_generated_dart_enums.zip';
    document.body.appendChild(zipLink);
    zipLink.click();
    document.body.removeChild(zipLink);
    URL.revokeObjectURL(zipUrl);
    
    console.log(`%cZIP file created with ${Object.keys(files).length} files!`, "color: green; font-weight: bold");
  };
}

for (let page = 0; page < docPages.length; page++) {
  setTimeout(() => {
    const button = document.querySelector(`a[href="${docPages[page].path}"]`);
    button.click();
    const pageKey = docPages[page].key;
    console.log(`%c${button.innerText.trim()} (${pageKey})`, "color: green; font-size: 20px");
    
    setTimeout(() => {
      collectVariables(pageKey);

      if (page === docPages.length - 1) {
        setTimeout(() => {
          saveCollectedData();
        }, 2000);
      }
    }, 1000);
  }, 3000 * page);
}