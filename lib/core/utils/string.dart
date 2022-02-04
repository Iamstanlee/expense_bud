String pluralize(String s, int length) {
  if (length == 1) return s;
  return "${s}s";
}

String titleCaseSingle(String s) => '${s[0].toUpperCase()}${s.substring(1)}';

String titleCase(String s) => s.split(" ").map(titleCaseSingle).join(" ");

String titleSlug(String value) {
  String capitalize(String s) => s[0].toLowerCase() + s.substring(1);
  List<String> words = value.trim().split(" ");
  words = words.map((w) => capitalize(w.toLowerCase())).toList();
  return words.join("_");
}

String defaultOnEmpty(String value, String defaultValue) =>
    value.isEmpty ? defaultValue : value;
