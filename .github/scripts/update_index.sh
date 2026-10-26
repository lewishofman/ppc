#!/bin/bash
set -euo pipefail

HTML_FILE="index.html"

TODO_TASKS=$(awk '/^ToDo Tasks:/{flag=1; next} /^Done Tasks:/{flag=0} flag && NF' "$1")
DONE_TASKS=$(awk '/^Done Tasks:/{flag=1; next} flag && NF' "$1")
UNIT_TEST_RESULTS=$(cat "$2")

update_pre() {
    SECTION_ID="$1" SECTION_CONTENT="$2" perl -i -0777 -pe '
        BEGIN {
            $id = $ENV{"SECTION_ID"};
            $content = $ENV{"SECTION_CONTENT"};
            $content =~ s/&/&amp;/g;
            $content =~ s/</&lt;/g;
            $content =~ s/>/&gt;/g;
        }
        s{(<pre id="\Q$id\E">).*?(</pre>)}{$1 . "\n" . $content . "\n" . $2}gse;
    ' "$3"
}

update_pre "pending" "$TODO_TASKS" "$HTML_FILE"
update_pre "completed" "$DONE_TASKS" "$HTML_FILE"
update_pre "unittest" "$UNIT_TEST_RESULTS" "$HTML_FILE"

git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"

git add "$HTML_FILE"

if git diff --cached --quiet; then
    echo "No report changes to commit."
else
    git commit -m "Update task and test report"
    git push
fi
