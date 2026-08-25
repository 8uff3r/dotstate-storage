# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_dotstate_global_optspecs
	string join \n no-colors h/help V/version
end

function __fish_dotstate_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_dotstate_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_dotstate_using_subcommand
	set -l cmd (__fish_dotstate_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c dotstate -n "__fish_dotstate_needs_command" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_needs_command" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_needs_command" -s V -l version -d 'Print version'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "sync" -d 'Sync with remote: commit, pull (with rebase), and push'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "list" -d 'List all synced files'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "add" -d 'Add a file to sync'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "remove" -d 'Remove a file from sync'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "activate" -d 'Activate the symlinks, restores app state after deactivation'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "deactivate" -d 'Deactivate symlinks. this might be useful if you are going to uninstall dotstate or you need the original files'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "doctor" -d 'Run diagnostics and optionally fix issues'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "logs" -d 'Shows logs location and how to view them'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "config" -d 'Configuration file location'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "repository" -d 'Repository location'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "help" -d 'Show help for a specific command'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "upgrade" -d 'Check for updates and optionally upgrade `DotState`'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "packages" -d 'Manage packages for profiles'
complete -c dotstate -n "__fish_dotstate_needs_command" -f -a "completions" -d 'Generate command-line completions'
complete -c dotstate -n "__fish_dotstate_using_subcommand sync" -s m -l message -d 'Custom commit message' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand sync" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand sync" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand list" -s v -l verbose -d 'Show detailed information'
complete -c dotstate -n "__fish_dotstate_using_subcommand list" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand list" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand add" -l common -d 'Add as a common file (shared across all profiles)'
complete -c dotstate -n "__fish_dotstate_using_subcommand add" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand add" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand remove" -l common -d 'Remove from common files (shared across all profiles)'
complete -c dotstate -n "__fish_dotstate_using_subcommand remove" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand remove" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand activate" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand activate" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand deactivate" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand deactivate" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand doctor" -l fix -d 'Attempt to auto-fix detected issues'
complete -c dotstate -n "__fish_dotstate_using_subcommand doctor" -s v -l verbose -d 'Show detailed diagnostic information'
complete -c dotstate -n "__fish_dotstate_using_subcommand doctor" -l json -d 'Output results as JSON for scripting'
complete -c dotstate -n "__fish_dotstate_using_subcommand doctor" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand doctor" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand logs" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand logs" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand config" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand config" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand repository" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand repository" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand help" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand help" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand upgrade" -l check -d 'Check for updates without prompting to install'
complete -c dotstate -n "__fish_dotstate_using_subcommand upgrade" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand upgrade" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and not __fish_seen_subcommand_from list add remove check install help" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and not __fish_seen_subcommand_from list add remove check install help" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and not __fish_seen_subcommand_from list add remove check install help" -f -a "list" -d 'List packages for a profile'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and not __fish_seen_subcommand_from list add remove check install help" -f -a "add" -d 'Add a package to a profile'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and not __fish_seen_subcommand_from list add remove check install help" -f -a "remove" -d 'Remove a package from a profile'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and not __fish_seen_subcommand_from list add remove check install help" -f -a "check" -d 'Check installation status of packages'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and not __fish_seen_subcommand_from list add remove check install help" -f -a "install" -d 'Install all missing packages'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and not __fish_seen_subcommand_from list add remove check install help" -f -a "help" -d 'Show help for packages commands'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from list" -s p -l profile -d 'Target profile (defaults to active profile)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from list" -s v -l verbose -d 'Show detailed package information'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from list" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -s p -l profile -d 'Target profile (defaults to active profile)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -s n -l name -d 'Package display name' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -s m -l manager -d 'Package manager (brew, cargo, apt, npm, pip, custom, etc.)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -s b -l binary -d 'Binary name to check for existence' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -l description -d 'Optional description' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -l package-name -d 'Package name in the manager (defaults to binary name)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -l install-command -d 'Install command (required for custom manager)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -l existence-check -d 'Command to check if package exists (optional, for custom)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from remove" -s p -l profile -d 'Target profile (defaults to active profile)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from remove" -s y -l yes -d 'Skip confirmation prompt'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from remove" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from check" -s p -l profile -d 'Target profile (defaults to active profile)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from check" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from check" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from install" -s p -l profile -d 'Target profile (defaults to active profile)' -r
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from install" -s v -l verbose -d 'Show package manager output'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from install" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from install" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from help" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand packages; and __fish_seen_subcommand_from help" -s h -l help -d 'Print help'
complete -c dotstate -n "__fish_dotstate_using_subcommand completions" -l no-colors -d 'Disable colors in the TUI (also respects `NO_COLOR` env var)'
complete -c dotstate -n "__fish_dotstate_using_subcommand completions" -s h -l help -d 'Print help'
