#!/usr/bin/env bash
set -euo pipefail
worker="$PWD/$1"
cd "$TEST_TMPDIR"
cat >compiler.sh <<'COMPILER'
#!/usr/bin/env bash
printf '%b\n' "$WERROR_DIAGNOSTIC" >&2
exit "${WERROR_COMPILER_EXIT:-0}"
COMPILER
chmod +x compiler.sh
compiler="$PWD/compiler.sh"
export WERROR_DIAGNOSTIC='warning: selected message [chosen_id]'
export WERROR_COMPILER_EXIT=0

run_case() {
    local expected="$1"
    shift
    local actual=0
    "$worker" "$compiler" "$@" >output.txt 2>&1 || actual=$?
    if [[ "$actual" != "$expected" ]]; then
        cat output.txt >&2
        echo "Expected $expected, got $actual: $*" >&2
        exit 1
    fi
}
run_case 0
grep -Fx 'warning: selected message [chosen_id]' output.txt
run_case 1 -Xwrapped-swift=-werror-id=chosen_id
grep -Fx 'error: selected message [chosen_id] (promoted_from_warning)' output.txt
run_case 0 -Xwrapped-swift=-werror-id=other_id
run_case 1 '-Xwrapped-swift=-werror-id-pattern.chosen_id=selected message'
run_case 0 '-Xwrapped-swift=-werror-id-pattern.chosen_id=other message'
run_case 1 '-Xwrapped-swift=-werror-id-pattern.chosen_id=other message' '-Xwrapped-swift=-werror-id-pattern.chosen_id=selected message'
export WERROR_DIAGNOSTIC='warning: selected message'
run_case 1 '-Xwrapped-swift=-werror-no-id-pattern=selected message'
run_case 0 '-Xwrapped-swift=-werror-no-id-pattern=other message'
export WERROR_DIAGNOSTIC='warning: selected message [outer_id]; [chosen_id]'
run_case 1 -Xwrapped-swift=-werror-id=chosen_id
export WERROR_DIAGNOSTIC='\033[1;33mwarning: selected message [chosen_id]\033[0m'
run_case 1 -Xwrapped-swift=-werror-id=chosen_id
grep -F 'promoted_from_warning' output.txt
export WERROR_COMPILER_EXIT=7
run_case 7 -Xwrapped-swift=-werror-id=chosen_id
export WERROR_COMPILER_EXIT=0
export WERROR_DIAGNOSTIC='warning: selected message [chosen_id]'
# A second persistent request must not inherit the first request's controls.
status=0
printf '%s\n' \
    '{"requestId":1,"arguments":["-Xwrapped-swift=-werror-id=chosen_id"],"inputs":[]}' \
    '{"requestId":2,"arguments":[],"inputs":[]}' \
    '{"requestId":3,"arguments":["-Xwrapped-swift=-werror-id-pattern.chosen_id=\\bselected\\b"],"inputs":[]}' |
    "$worker" --persistent_worker "$compiler" >responses.json 2>worker.log || status=$?
[[ "$status" == 254 ]]
tr '}' '\n' <responses.json >responses.txt
grep -F '"requestId":1' responses.txt | grep -F '"exitCode":1'
grep -F '"requestId":2' responses.txt | grep -F '"exitCode":0'
grep -F '"requestId":3' responses.txt | grep -F '"exitCode":1'
