import 'package:fuzzy/data/fuzzy_options.dart';
import 'package:passport_hub/common/models/country.dart';

FuzzyOptions<Country> getFuzzyOptions() {
  return FuzzyOptions<Country>(
    shouldNormalize: true,
    threshold: 0.4,
    distance: 50,
    keys: [
      WeightedKey(
        name: 'name',
        getter: (Country c) => c.name ?? '',
        weight: 3,
      ),
    ],
  );
}
