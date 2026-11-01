"""Check your answer to a case without seeing the solution.

    python check.py 1 "first answer" "second answer"

Answers are compared after removing accents, case and punctuation, against
SHA-256 hashes in cases.json, so the solutions are not written anywhere in the
repo. A timestamp also counts as its date or its time ("2019-03-12 21:47:00"
answers "21:47"). No dependencies beyond Python 3.8.

Comprueba tu respuesta sin ver la solución. Sin acentos, mayúsculas ni
puntuación; las soluciones sólo están como hash en cases.json.
"""

import hashlib
import json
import re
import sys
import unicodedata
from pathlib import Path

PUNCT = re.compile(r"[^\w\s]", re.UNICODE)
SPACES = re.compile(r"\s+")
TIMESTAMP = re.compile(r"^(\d{4}-\d{2}-\d{2})[ T](\d{2}:\d{2})(:\d{2})?")


def normalize(text):
    text = unicodedata.normalize("NFKD", str(text))
    text = "".join(ch for ch in text if not unicodedata.combining(ch))
    text = PUNCT.sub(" ", text.lower())
    return SPACES.sub(" ", text).strip()


def forms(value):
    text = str(value)
    out = [normalize(text)]
    m = TIMESTAMP.match(text.strip())
    if m:
        out += [normalize(m.group(1)), normalize(m.group(2)), normalize(m.group(1) + " " + m.group(2))]
        if m.group(3):
            out.append(normalize(m.group(2) + m.group(3)))
    return out


def correct(field, answer):
    return any(hashlib.sha256(f.encode("utf-8")).hexdigest() in field["hashes"] for f in forms(answer))


def main(argv):
    cases = json.loads((Path(__file__).parent / "cases.json").read_text(encoding="utf-8"))
    if len(argv) < 2 or not argv[1].isdigit() or not 1 <= int(argv[1]) <= len(cases):
        print(__doc__.strip().split("\n\n")[0])
        for c in cases:
            print(f"  {c['n']}  {c['title']['en']} / {c['title']['es']}")
        return 2
    case = cases[int(argv[1]) - 1]
    answers = argv[2:]
    if len(answers) != len(case["fields"]):
        print(f"Case {case['n']} needs {len(case['fields'])} answers, in this order / necesita {len(case['fields'])} respuestas, en este orden:")
        for f in case["fields"]:
            print(f"  - {f['label']['en']} / {f['label']['es']}")
        return 2
    ok = True
    for field, answer in zip(case["fields"], answers):
        good = correct(field, answer)
        ok = ok and good
        print(f"  {'✓' if good else '✗'}  {field['label']['en']} / {field['label']['es']}: {answer}")
    if ok:
        print("\nCase closed. / Caso cerrado.")
        print(f"28 more cases in the full game / 28 casos más en el juego completo: {case['more']}")
        return 0
    print("\nNot yet. / Todavía no.")
    return 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
