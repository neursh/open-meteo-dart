const replacements = {
  'pm2_5': 'pm2p5',
  'windspeed': 'wind_speed',
  'winddirection': 'wind_direction',
};

const defaultValue = r'$default$';

const staticSuffixes = {
  'v.aggregation': {
    defaultValue: 'Aggregation.none',
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

final regexSuffixes = {
  'v.altitude': r'_(\d+)m$',
  '(v.depth, v.depthTo)': r'_(\d+)_to_(\d+)cm$',
  'v.depth': r'_(\d+)cm$',
  'v.pressureLevel': r'_(\d+)hPa',
}.map((key, regex) => MapEntry(key, RegExp(regex)));

Map<String, Map<String, Map<String, String>>> buildIndex(List<String> inputs) {
  Map<String, Map<String, Map<String, String>>> data = {};
  for (String input in inputs) {
    Map<String, String> properties = {};
    String root = computeRoot(input, properties);

    data.putIfAbsent(root, () => {});
    data[root]![input] = properties;
  }
  return data;
}

String computeRoot(String root, Map<String, String> properties) {
  for (MapEntry<String, Map<String, String>> suffixGroup
      in staticSuffixes.entries) {
    if (properties.containsKey(suffixGroup.key)) continue;

    for (MapEntry<String, String> suffix in suffixGroup.value.entries) {
      if (!root.endsWith(suffix.key)) continue;

      properties[suffixGroup.key] = suffix.value;
      return computeRoot(
          root.substring(0, root.length - suffix.key.length), properties);
    }
  }

  for (MapEntry<String, RegExp> regexSuffix in regexSuffixes.entries) {
    if (properties.containsKey(regexSuffix.key)) continue;

    RegExpMatch? match = regexSuffix.value.firstMatch(root);
    if (match == null) continue;

    List<String?> captures =
        match.groups(List.generate(match.groupCount, (i) => i + 1));
    properties[regexSuffix.key] = '(${captures.join(',')})';
    return computeRoot(root.substring(0, match.start), properties);
  }

  for (var replacement in replacements.entries) {
    root = root.replaceAll(replacement.key, replacement.value);
  }

  return root;
}

void main() {
  print(buildIndex([]));
}
