#compdef ast-grep

autoload -U is-at-least

_ast-grep() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_ast-grep_commands" \
"*::: :->ast-grep" \
&& ret=0
    case $state in
    (ast-grep)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:ast-grep-command-$line[1]:"
        case $line[1] in
            (run)
_arguments "${_arguments_options[@]}" : \
'-p+[AST pattern to match]:PATTERN:_default' \
'--pattern=[AST pattern to match]:PATTERN:_default' \
'(-k --kind)--selector=[AST kind to extract sub-part of pattern to match]:KIND:_default' \
'(-k --kind)--strictness=[The strictness of the pattern]:STRICTNESS:((cst\:"Match all nodes exactly"
smart\:"Match all nodes except source trivial nodes"
ast\:"Match only ast nodes"
relaxed\:"Match ast nodes except comments"
signature\:"Match ast nodes except comments, without text"
template\:"Similar to smart but match text only, node kinds are ignored"))' \
'(-p --pattern)-k+[AST kind to match]:KIND:_default' \
'(-p --pattern)--kind=[AST kind to match]:KIND:_default' \
'-r+[String to replace the matched AST node]:FIX:_default' \
'--rewrite=[String to replace the matched AST node]:FIX:_default' \
'-l+[The language of the pattern. Supported languages are\: \[Bash, C, Cpp, CSharp, Css, Dart, Elixir, Go, Haskell, Hcl, Html, Java, JavaScript, Json, Kotlin, Lua, Markdown, Nix, Php, Python, Ruby, Rust, Scala, Solidity, Swift, Tsx, TypeScript, Yaml, Zig\]]:LANG:_default' \
'--lang=[The language of the pattern. Supported languages are\: \[Bash, C, Cpp, CSharp, Css, Dart, Elixir, Go, Haskell, Hcl, Html, Java, JavaScript, Json, Kotlin, Lua, Markdown, Nix, Php, Python, Ruby, Rust, Scala, Solidity, Swift, Tsx, TypeScript, Yaml, Zig\]]:LANG:_default' \
'--debug-query=[Print query pattern'\''s tree-sitter AST. Requires lang be set explicitly]::format:((pattern\:"Print the query parsed in Pattern format"
ast\:"Print the query in tree-sitter AST format, only named nodes are shown"
cst\:"Print the query in tree-sitter CST format, both named and unnamed nodes are shown"
sexp\:"Print the query in S-expression format"))' \
'*--no-ignore=[Do not respect hidden file system or ignore files (.gitignore, .ignore, etc.)]:FILE_TYPE:((hidden\:"Search hidden files and directories. By default, hidden files and directories are skipped"
dot\:"Don'\''t respect .ignore files. This does *not* affect whether ast-grep will ignore files and directories whose names begin with a dot. For that, use --no-ignore hidden"
exclude\:"Don'\''t respect ignore files that are manually configured for the repository such as git'\''s '\''.git/info/exclude'\''"
global\:"Don'\''t respect ignore files that come from "global" sources such as git'\''s \`core.excludesFile\` configuration option (which defaults to \`\$HOME/.config/git/ignore\`)"
parent\:"Don'\''t respect ignore files (.gitignore, .ignore, etc.) in parent directories"
vcs\:"Don'\''t respect version control ignore files (.gitignore, etc.). This implies --no-ignore parent for VCS files. Note that .ignore files will continue to be respected"))' \
'*--globs=[Include or exclude file paths]:GLOBS:_default' \
'-j+[Set the approximate number of threads to use]:NUM:_default' \
'--threads=[Set the approximate number of threads to use]:NUM:_default' \
'(-i --interactive)--json=[Output matches in structured JSON]::STYLE:((pretty\:"Prints the matches as a pretty-printed JSON array, with indentation and line breaks. This is useful for human readability, but not for parsing by other programs. This is the default value for the \`--json\` option"
stream\:"Prints each match as a separate JSON object, followed by a newline character. This is useful for streaming the output to other programs that can read one object per line"
compact\:"Prints the matches as a single-line JSON array, without any whitespace. This is useful for saving space and minimizing the output size"))' \
'--color=[Controls output color]:WHEN:((auto\:"Try to use colors, but don'\''t force the issue. If the output is piped to another program, or the console isn'\''t available on Windows, or if TERM=dumb, or if \`NO_COLOR\` is defined, for example, then don'\''t use colors"
always\:"Try very hard to emit colors. This includes emitting ANSI colors on Windows if the console API is unavailable (not implemented yet)"
ansi\:"Ansi is like Always, except it never tries to use anything other than emitting ANSI color codes"
never\:"Never emit colors"))' \
'--inspect=[Inspect information for file/rule discovery and scanning]:GRANULARITY:((nothing\:"Do not show any tracing information"
summary\:"Show summary about how many files are scanned and skipped"
entity\:"Show per-file/per-rule tracing information"))' \
'(-C --context)-A+[Show NUM lines after each match]:NUM:_default' \
'(-C --context)--after=[Show NUM lines after each match]:NUM:_default' \
'(-C --context)-B+[Show NUM lines before each match]:NUM:_default' \
'(-C --context)--before=[Show NUM lines before each match]:NUM:_default' \
'-C+[Show NUM lines around each match]:NUM:_default' \
'--context=[Show NUM lines around each match]:NUM:_default' \
'--heading=[Controls whether to print the file name as heading]:WHEN:((auto\:"Print heading for terminal tty but not for piped output"
always\:"Always print heading regardless of output type"
never\:"Never print heading regardless of output type"))' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'--follow[Follow symbolic links]' \
'--stdin[Enable search code from StdIn]' \
'-i[Start interactive edit session]' \
'--interactive[Start interactive edit session]' \
'-U[Apply all rewrite without confirmation if true]' \
'--update-all[Apply all rewrite without confirmation if true]' \
'(-i --interactive --json -U --update-all)--files-with-matches[Print only the paths with at least one match and suppress match contents]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::paths -- The paths to search. You can provide multiple paths separated by spaces:_files' \
&& ret=0
;;
(scan)
_arguments "${_arguments_options[@]}" : \
'-r+[Scan the codebase with the single rule located at the path RULE_FILE]:RULE_FILE:_files' \
'--rule=[Scan the codebase with the single rule located at the path RULE_FILE]:RULE_FILE:_files' \
'(-r --rule)--inline-rules=[Scan the codebase with a rule defined by the provided RULE_TEXT]:RULE_TEXT:_default' \
'(--json -i --interactive)--format=[Output warning/error messages in different formats]:FORMAT:(github sarif)' \
'(--json)--report-style=[]:REPORT_STYLE:((rich\:"Output a richly formatted diagnostic, with source code previews"
medium\:"Output a condensed diagnostic, with a line number, severity, message and notes (if any)"
short\:"Output a short diagnostic, with a line number, severity, and message"))' \
'(-r --rule)--filter=[Scan the codebase with rules with ids matching REGEX]:REGEX:_default' \
'--min-severity=[Set the minimum severity of rules to scan]:SEVERITY:_default' \
'*--error=[Set rule severity to error]::RULE_ID:_default' \
'*--warning=[Set rule severity to warning]::RULE_ID:_default' \
'*--info=[Set rule severity to info]::RULE_ID:_default' \
'*--hint=[Set rule severity to hint]::RULE_ID:_default' \
'*--off=[Turn off rule]::RULE_ID:_default' \
'*--no-ignore=[Do not respect hidden file system or ignore files (.gitignore, .ignore, etc.)]:FILE_TYPE:((hidden\:"Search hidden files and directories. By default, hidden files and directories are skipped"
dot\:"Don'\''t respect .ignore files. This does *not* affect whether ast-grep will ignore files and directories whose names begin with a dot. For that, use --no-ignore hidden"
exclude\:"Don'\''t respect ignore files that are manually configured for the repository such as git'\''s '\''.git/info/exclude'\''"
global\:"Don'\''t respect ignore files that come from "global" sources such as git'\''s \`core.excludesFile\` configuration option (which defaults to \`\$HOME/.config/git/ignore\`)"
parent\:"Don'\''t respect ignore files (.gitignore, .ignore, etc.) in parent directories"
vcs\:"Don'\''t respect version control ignore files (.gitignore, etc.). This implies --no-ignore parent for VCS files. Note that .ignore files will continue to be respected"))' \
'*--globs=[Include or exclude file paths]:GLOBS:_default' \
'-j+[Set the approximate number of threads to use]:NUM:_default' \
'--threads=[Set the approximate number of threads to use]:NUM:_default' \
'(-i --interactive)--json=[Output matches in structured JSON]::STYLE:((pretty\:"Prints the matches as a pretty-printed JSON array, with indentation and line breaks. This is useful for human readability, but not for parsing by other programs. This is the default value for the \`--json\` option"
stream\:"Prints each match as a separate JSON object, followed by a newline character. This is useful for streaming the output to other programs that can read one object per line"
compact\:"Prints the matches as a single-line JSON array, without any whitespace. This is useful for saving space and minimizing the output size"))' \
'--color=[Controls output color]:WHEN:((auto\:"Try to use colors, but don'\''t force the issue. If the output is piped to another program, or the console isn'\''t available on Windows, or if TERM=dumb, or if \`NO_COLOR\` is defined, for example, then don'\''t use colors"
always\:"Try very hard to emit colors. This includes emitting ANSI colors on Windows if the console API is unavailable (not implemented yet)"
ansi\:"Ansi is like Always, except it never tries to use anything other than emitting ANSI color codes"
never\:"Never emit colors"))' \
'--inspect=[Inspect information for file/rule discovery and scanning]:GRANULARITY:((nothing\:"Do not show any tracing information"
summary\:"Show summary about how many files are scanned and skipped"
entity\:"Show per-file/per-rule tracing information"))' \
'(-C --context)-A+[Show NUM lines after each match]:NUM:_default' \
'(-C --context)--after=[Show NUM lines after each match]:NUM:_default' \
'(-C --context)-B+[Show NUM lines before each match]:NUM:_default' \
'(-C --context)--before=[Show NUM lines before each match]:NUM:_default' \
'-C+[Show NUM lines around each match]:NUM:_default' \
'--context=[Show NUM lines around each match]:NUM:_default' \
'(-i --interactive)--max-results=[Show at most NUM results and stop running once the limit is reached]:NUM:_default' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'--include-metadata[Include rule metadata in the json output]' \
'--follow[Follow symbolic links]' \
'--stdin[Enable search code from StdIn]' \
'-i[Start interactive edit session]' \
'--interactive[Start interactive edit session]' \
'-U[Apply all rewrite without confirmation if true]' \
'--update-all[Apply all rewrite without confirmation if true]' \
'(-i --interactive --json -U --update-all)--files-with-matches[Print only the paths with at least one match and suppress match contents]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::paths -- The paths to search. You can provide multiple paths separated by spaces:_files' \
&& ret=0
;;
(test)
_arguments "${_arguments_options[@]}" : \
'-t+[the directories to search test YAML files]:TEST_DIR:_files' \
'--test-dir=[the directories to search test YAML files]:TEST_DIR:_files' \
'--snapshot-dir=[Specify the directory name storing snapshots. Default to __snapshots__]:SNAPSHOT_DIR:_files' \
'-f+[Only run rule test cases that matches REGEX]:REGEX:_default' \
'--filter=[Only run rule test cases that matches REGEX]:REGEX:_default' \
'--color=[Controls output color]:WHEN:((auto\:"Try to use colors, but don'\''t force the issue. If the output is piped to another program, or the console isn'\''t available on Windows, or if TERM=dumb, or if \`NO_COLOR\` is defined, for example, then don'\''t use colors"
always\:"Try very hard to emit colors. This includes emitting ANSI colors on Windows if the console API is unavailable (not implemented yet)"
ansi\:"Ansi is like Always, except it never tries to use anything other than emitting ANSI color codes"
never\:"Never emit colors"))' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'(-U --update-all)--skip-snapshot-tests[Only check if the test code is valid, without checking rule output. Turn it on when you want to ignore the output of rules. Conflicts with --update-all]' \
'-U[Update the content of all snapshots that have changed in test. Conflicts with --skip-snapshot-tests]' \
'--update-all[Update the content of all snapshots that have changed in test. Conflicts with --skip-snapshot-tests]' \
'-i[Start an interactive review to update snapshots selectively]' \
'--interactive[Start an interactive review to update snapshots selectively]' \
'--include-off[Include \`severity\:off\` rules in test]' \
'--follow[Follow symbolic links while searching test YAML files]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(new)
_arguments "${_arguments_options[@]}" : \
'-l+[The language of the item to create]:LANG:_default' \
'--lang=[The language of the item to create]:LANG:_default' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'-y[Accept all default options without interactive input during creation]' \
'--yes[Accept all default options without interactive input during creation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::name -- The id of the item to create:_default' \
":: :_ast-grep__subcmd__new_commands" \
"*::: :->new" \
&& ret=0

    case $state in
    (new)
        words=($line[2] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:ast-grep-new-command-$line[2]:"
        case $line[2] in
            (project)
_arguments "${_arguments_options[@]}" : \
'-l+[The language of the item to create]:LANG:_default' \
'--lang=[The language of the item to create]:LANG:_default' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'-y[Accept all default options without interactive input during creation]' \
'--yes[Accept all default options without interactive input during creation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::name -- The id of the item to create:_default' \
&& ret=0
;;
(rule)
_arguments "${_arguments_options[@]}" : \
'-l+[The language of the item to create]:LANG:_default' \
'--lang=[The language of the item to create]:LANG:_default' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'-y[Accept all default options without interactive input during creation]' \
'--yes[Accept all default options without interactive input during creation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::name -- The id of the item to create:_default' \
&& ret=0
;;
(test)
_arguments "${_arguments_options[@]}" : \
'-l+[The language of the item to create]:LANG:_default' \
'--lang=[The language of the item to create]:LANG:_default' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'-y[Accept all default options without interactive input during creation]' \
'--yes[Accept all default options without interactive input during creation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::name -- The id of the item to create:_default' \
&& ret=0
;;
(util)
_arguments "${_arguments_options[@]}" : \
'-l+[The language of the item to create]:LANG:_default' \
'--lang=[The language of the item to create]:LANG:_default' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'-y[Accept all default options without interactive input during creation]' \
'--yes[Accept all default options without interactive input during creation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::name -- The id of the item to create:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_ast-grep__subcmd__new__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:ast-grep-new-help-command-$line[1]:"
        case $line[1] in
            (project)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(rule)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(test)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(util)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(lsp)
_arguments "${_arguments_options[@]}" : \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(outline)
_arguments "${_arguments_options[@]}" : \
'-l+[Specify the input language]:LANG:_default' \
'--lang=[Specify the input language]:LANG:_default' \
'--json=[Output outline entries in structured JSON]::STYLE:((pretty\:"Prints the matches as a pretty-printed JSON array, with indentation and line breaks. This is useful for human readability, but not for parsing by other programs. This is the default value for the \`--json\` option"
stream\:"Prints each match as a separate JSON object, followed by a newline character. This is useful for streaming the output to other programs that can read one object per line"
compact\:"Prints the matches as a single-line JSON array, without any whitespace. This is useful for saving space and minimizing the output size"))' \
'--color=[Controls output color]:WHEN:((auto\:"Try to use colors, but don'\''t force the issue. If the output is piped to another program, or the console isn'\''t available on Windows, or if TERM=dumb, or if \`NO_COLOR\` is defined, for example, then don'\''t use colors"
always\:"Try very hard to emit colors. This includes emitting ANSI colors on Windows if the console API is unavailable (not implemented yet)"
ansi\:"Ansi is like Always, except it never tries to use anything other than emitting ANSI color codes"
never\:"Never emit colors"))' \
'--items=[Select which top-level items to include]:ITEMS:((auto\:"Use \`structure\` for file or stdin input, \`exports\` when any directory is given"
structure\:"Top-level items defined locally in the file, excluding imports"
exports\:"Top-level items exported from the file or module"
imports\:"Top-level items imported from other files or modules"
all\:"All top-level items, including imports and exports"))' \
'--type=[Keep only top-level items with these comma-separated symbol types]:TYPE[,TYPE...]:_default' \
'--match=[Keep only top-level items matching this regex]:REGEX:_default' \
'--view=[Select the text presentation]:VIEW:((auto\:"Use \`digest\` for file or stdin input, \`names\` when any directory is given"
names\:"One grouped name line per symbol type for each file"
signatures\:"One source/signature line per top-level item"
digest\:"Signatures plus compact member name digests"
expanded\:"Signatures plus one source/signature line per direct member"))' \
'*--outline-rules=[Load additional outline extractor definitions]:FILE:_files' \
'*--no-ignore=[Do not respect hidden file system or ignore files (.gitignore, .ignore, etc.)]:FILE_TYPE:((hidden\:"Search hidden files and directories. By default, hidden files and directories are skipped"
dot\:"Don'\''t respect .ignore files. This does *not* affect whether ast-grep will ignore files and directories whose names begin with a dot. For that, use --no-ignore hidden"
exclude\:"Don'\''t respect ignore files that are manually configured for the repository such as git'\''s '\''.git/info/exclude'\''"
global\:"Don'\''t respect ignore files that come from "global" sources such as git'\''s \`core.excludesFile\` configuration option (which defaults to \`\$HOME/.config/git/ignore\`)"
parent\:"Don'\''t respect ignore files (.gitignore, .ignore, etc.) in parent directories"
vcs\:"Don'\''t respect version control ignore files (.gitignore, etc.). This implies --no-ignore parent for VCS files. Note that .ignore files will continue to be respected"))' \
'*--globs=[Include or exclude file paths]:GLOBS:_default' \
'-j+[Set the approximate number of threads to use]:NUM:_default' \
'--threads=[Set the approximate number of threads to use]:NUM:_default' \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'--pub-members[Display only public members in member views]' \
'--no-default-outline-rules[Do not load bundled outline extractor definitions]' \
'--follow[Follow symbolic links]' \
'--stdin[Enable search code from StdIn]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::paths -- The paths to search. You can provide multiple paths separated by spaces:_files' \
&& ret=0
;;
(completions)
_arguments "${_arguments_options[@]}" : \
'-c+[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--config=[Path to ast-grep root config, default is sgconfig.yml]:CONFIG_FILE:_files' \
'--custom-languages=[Control how sgconfig.yml handles native custom language libraries (default\: ignore)]:CUSTOM_LANGUAGES:((allow\:"Load native custom language libraries for this invocation"
ignore\:"Skip native custom language libraries without reporting an error"
trust\:"Load native custom language libraries and remember this project"
revoke\:"Forget this project and ignore its native custom language libraries"))' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::shell -- Output the completion file for given shell. If not provided, shell flavor will be inferred from environment:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_ast-grep__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:ast-grep-help-command-$line[1]:"
        case $line[1] in
            (run)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(scan)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(test)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(new)
_arguments "${_arguments_options[@]}" : \
":: :_ast-grep__subcmd__help__subcmd__new_commands" \
"*::: :->new" \
&& ret=0

    case $state in
    (new)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:ast-grep-help-new-command-$line[1]:"
        case $line[1] in
            (project)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(rule)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(test)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(util)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(lsp)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(outline)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(completions)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_ast-grep_commands] )) ||
_ast-grep_commands() {
    local commands; commands=(
'run:Run one time search or rewrite in command line. (default command)' \
'scan:Scan and rewrite code by configuration' \
'test:Test ast-grep rules' \
'new:Create new ast-grep project or items like rules/tests' \
'lsp:Start language server' \
'outline:Explore code structure for symbols, imports, exports, and members' \
'completions:Generate shell completion script' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'ast-grep commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__completions_commands] )) ||
_ast-grep__subcmd__completions_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep completions commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help_commands] )) ||
_ast-grep__subcmd__help_commands() {
    local commands; commands=(
'run:Run one time search or rewrite in command line. (default command)' \
'scan:Scan and rewrite code by configuration' \
'test:Test ast-grep rules' \
'new:Create new ast-grep project or items like rules/tests' \
'lsp:Start language server' \
'outline:Explore code structure for symbols, imports, exports, and members' \
'completions:Generate shell completion script' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'ast-grep help commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__completions_commands] )) ||
_ast-grep__subcmd__help__subcmd__completions_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help completions commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__help_commands] )) ||
_ast-grep__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help help commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__lsp_commands] )) ||
_ast-grep__subcmd__help__subcmd__lsp_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help lsp commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__new_commands] )) ||
_ast-grep__subcmd__help__subcmd__new_commands() {
    local commands; commands=(
'project:Create an new project by scaffolding' \
'rule:Create a new rule' \
'test:Create a new test case' \
'util:Create a new global utility rule' \
    )
    _describe -t commands 'ast-grep help new commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__new__subcmd__project_commands] )) ||
_ast-grep__subcmd__help__subcmd__new__subcmd__project_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help new project commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__new__subcmd__rule_commands] )) ||
_ast-grep__subcmd__help__subcmd__new__subcmd__rule_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help new rule commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__new__subcmd__test_commands] )) ||
_ast-grep__subcmd__help__subcmd__new__subcmd__test_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help new test commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__new__subcmd__util_commands] )) ||
_ast-grep__subcmd__help__subcmd__new__subcmd__util_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help new util commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__outline_commands] )) ||
_ast-grep__subcmd__help__subcmd__outline_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help outline commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__run_commands] )) ||
_ast-grep__subcmd__help__subcmd__run_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help run commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__scan_commands] )) ||
_ast-grep__subcmd__help__subcmd__scan_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help scan commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__help__subcmd__test_commands] )) ||
_ast-grep__subcmd__help__subcmd__test_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep help test commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__lsp_commands] )) ||
_ast-grep__subcmd__lsp_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep lsp commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new_commands] )) ||
_ast-grep__subcmd__new_commands() {
    local commands; commands=(
'project:Create an new project by scaffolding' \
'rule:Create a new rule' \
'test:Create a new test case' \
'util:Create a new global utility rule' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'ast-grep new commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__help_commands] )) ||
_ast-grep__subcmd__new__subcmd__help_commands() {
    local commands; commands=(
'project:Create an new project by scaffolding' \
'rule:Create a new rule' \
'test:Create a new test case' \
'util:Create a new global utility rule' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'ast-grep new help commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__help__subcmd__help_commands] )) ||
_ast-grep__subcmd__new__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new help help commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__help__subcmd__project_commands] )) ||
_ast-grep__subcmd__new__subcmd__help__subcmd__project_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new help project commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__help__subcmd__rule_commands] )) ||
_ast-grep__subcmd__new__subcmd__help__subcmd__rule_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new help rule commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__help__subcmd__test_commands] )) ||
_ast-grep__subcmd__new__subcmd__help__subcmd__test_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new help test commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__help__subcmd__util_commands] )) ||
_ast-grep__subcmd__new__subcmd__help__subcmd__util_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new help util commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__project_commands] )) ||
_ast-grep__subcmd__new__subcmd__project_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new project commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__rule_commands] )) ||
_ast-grep__subcmd__new__subcmd__rule_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new rule commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__test_commands] )) ||
_ast-grep__subcmd__new__subcmd__test_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new test commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__new__subcmd__util_commands] )) ||
_ast-grep__subcmd__new__subcmd__util_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep new util commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__outline_commands] )) ||
_ast-grep__subcmd__outline_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep outline commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__run_commands] )) ||
_ast-grep__subcmd__run_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep run commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__scan_commands] )) ||
_ast-grep__subcmd__scan_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep scan commands' commands "$@"
}
(( $+functions[_ast-grep__subcmd__test_commands] )) ||
_ast-grep__subcmd__test_commands() {
    local commands; commands=()
    _describe -t commands 'ast-grep test commands' commands "$@"
}

if [ "$funcstack[1]" = "_ast-grep" ]; then
    _ast-grep "$@"
else
    compdef _ast-grep ast-grep
fi
