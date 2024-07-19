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

typedef Index = Map<String, Map<String, Map<String, String>>>;

Index buildIndex(List<String> inputs) {
  Index index = {};
  for (final input in inputs) {
    Map<String, String> properties = {};
    String root = computeRoot(input, properties);

    index.putIfAbsent(root, () => {});
    index[root]![input] = properties;
  }
  return index;
}

String computeRoot(String root, Map<String, String> properties) {
  for (final suffixGroup in staticSuffixes.entries) {
    if (properties.containsKey(suffixGroup.key)) continue;

    for (final suffix in suffixGroup.value.entries) {
      if (!root.endsWith(suffix.key)) continue;

      properties[suffixGroup.key] = suffix.value;
      return computeRoot(
          root.substring(0, root.length - suffix.key.length), properties);
    }
  }

  for (final regexSuffix in regexSuffixes.entries) {
    if (properties.containsKey(regexSuffix.key)) continue;

    RegExpMatch? match = regexSuffix.value.firstMatch(root);
    if (match == null) continue;

    List<String?> captures =
        match.groups(List.generate(match.groupCount, (i) => i + 1));
    properties[regexSuffix.key] = '(${captures.join(',')})';
    return computeRoot(root.substring(0, match.start), properties);
  }

  for (final replacement in replacements.entries) {
    root = root.replaceAll(replacement.key, replacement.value);
  }

  return root;
}