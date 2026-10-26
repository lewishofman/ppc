#!/bin/bash
set -euo pipefail

cd /app

echo "Executing todo.py"
python3 /app/.github/scripts/todo.py | tee /app/todo_output.txt

echo "Executing todo-test.py"
python3 /app/.github/scripts/todo-test.py | tee /app/test_output.txt

echo "Executing update_index.sh"
bash /app/.github/scripts/update_index.sh \
    /app/todo_output.txt \
    /app/test_output.txt

echo "Done!"
