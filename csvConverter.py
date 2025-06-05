import csv

# Latin cases
cases = [
    ("nominative", "subject"),
    ("vocative", "used when addressing"),
    ("acusative", "object"),
    ("genative", "possession"),
    ("dative", "to/for"),
    ("ablative", "by/with/from")
]

# English descriptions for plural
case_english_plural = {
    "nominative": "they (subject)",
    "acusative": "them (object)",
    "genative": "of the {}s",
    "dative": "to the {}s",
    "ablative": "by/with/from the {}s",
    "vocative": "O {}s!"
}

# English singular
case_english_singular = {
    "nominative": "she (subject)",
    "acusative": "her (object)",
    "genative": "of the {}",
    "dative": "to the {}",
    "ablative": "by/with/from the {}",
    "vocative": "O {}!"
}

# Supported types
nounlike_types = ["noun", "adjective"]
verb_types = ["verb"]
other_types = ["adverb", "conjunction", "preposition", "interjection"]

with open("latin_words.csv", newline='', encoding='utf-8') as infile, \
     open("expanded_latin.csv", "w", newline='', encoding='utf-8') as outfile:

    reader = csv.DictReader(infile)
    writer = csv.writer(outfile)
    writer.writerow(["lat", "description"])

    for row in reader:
        word_type = row['type'].strip().lower()
        eng = row['eng'].strip()
        lat_base = row['lat'].strip()

        if word_type in nounlike_types:
            for num in ["singular", "plural"]:
                for case, desc in cases:
                    col_name = f"{case}_{num}" if f"{case}_{num}" in row else case
                    form = row.get(col_name, "").strip()
                    if not form:
                        continue

                    if num == "singular":
                        eng_desc = case_english_singular.get(case, "").format(eng)
                    else:
                        eng_desc = case_english_plural.get(case, "").format(eng)

                    description = f"{case.capitalize()} {num} {word_type} - {eng_desc}"
                    writer.writerow([form, description])

        elif word_type in verb_types:
            # Simple descriptions for verbs
            writer.writerow([lat_base, f"Infinitive verb - to {eng}"])
            writer.writerow(["", f"1st person singular - I {eng}"])
            writer.writerow(["", f"2nd person singular - you {eng}"])
            writer.writerow(["", f"3rd person singular - he/she {eng}s"])
            writer.writerow(["", f"1st person plural - we {eng}"])
            writer.writerow(["", f"2nd person plural - you (all) {eng}"])
            writer.writerow(["", f"3rd person plural - they {eng}"])

        elif word_type in other_types:
            # Generic description
            writer.writerow([lat_base, f"{word_type.capitalize()} - modifies or links meaning: '{eng}'"])
        else:
            # Unknown type
            writer.writerow([lat_base, f"Unrecognized type '{word_type}' - meaning: '{eng}'"])
