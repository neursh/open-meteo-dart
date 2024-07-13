const patterns = [
  {
    regex: /(\w+)_(\d+)_to_(\d+)cm/,
    parameters: ['depth', 'depthTo'],
  },
  {
    regex: /(\w+)_(\d+)cm/,
    parameters: ['depth'],
  },
];

function transformVariables(variables) {
  let data = new Map();
  outer: for (let varStr of [...variables]) {
    for (let pattern of [...patterns]) {
      let regexMatch = pattern.regex.exec(varStr);
      if (regexMatch === null) continue;

      let varName = regexMatch[1];
      let parametersStr = pattern.parameters.join(',');
      let key = varName + '/' + parametersStr;

      let variable;
      if (data.has(key)) {
        variable = data.get(key);
      } else {
        variable = {
          variable: varName,
          parameters: pattern.parameters,
          values: new Map(),
        };
      }

      variable.values.set(regexMatch.slice(2).join(','), varStr);
      data.set(key, variable);

      continue outer;
    }

    data.set(varStr, {
      variable: varStr,
      parameters: null,
      values: null,
    });
  }
}
