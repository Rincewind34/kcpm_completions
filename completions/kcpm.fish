function __fish_kcpm_global_optspecs
    string join "no-update"
end

function __fish_kcpm_needs_command
    $__fish_kcpm_at_root
end

function __fish_kcpm_using_command
    contains $__fish_kcpm_subcommand $argv
end



function __fish_kcpm_libraries
    kcpm --no-update libraries 2> /dev/null
end

function __fish_kcpm_phraselibs
    kcpm --no-update phraselibs 2> /dev/null | sed 's/$/\t/'
end



### install
set --local librariesCommands install check create copy-to-drive validate
complete --no-files -c 'kcpm' --condition "__fish_kcpm_needs_command" --arguments 'libraries' -d "Manage your sample libraries."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and not __fish_seen_subcommand_from $librariesCommands" --long 'help'               -d "Print detailed help about libraries subcommand."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and not __fish_seen_subcommand_from $librariesCommands" --arguments 'install'       -d "Install sample libraries."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and not __fish_seen_subcommand_from $librariesCommands" --arguments 'check'         -d "Checks if libraries are installed."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and not __fish_seen_subcommand_from $librariesCommands" --arguments 'copy-to-drive' -d "Copies installed libraries to drive."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and not __fish_seen_subcommand_from $librariesCommands" --arguments 'validate'      -d "Checks integrity of registered libraires."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from install"        --long 'dry'      -d "Perform all steps without actually installing them."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from install"        --long 'force'    -d "Do not check if specified libraries are already installed."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from install"        --require-parameter --arguments "(__fish_kcpm_libraries)"
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from check"          --long 'all'      -d "Check for all registered libraries."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from check"          --long 'drive'    -d "Check installations on external drive."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from check"          --require-parameter --arguments "(__fish_kcpm_libraries)"
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from copy-to-drive"  --long 'all'      -d "Copy all installed libraries."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from copy-to-drive"  --long 'force'    -d "Don't check if libraries are already copied to external drive."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from copy-to-drive"  --require-parameter --arguments "(__fish_kcpm_libraries)"
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from validate"       --long 'verbose'  -d "Enable more verbose mode."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command libraries; and __fish_seen_subcommand_from validate"       --require-parameter --arguments "(__fish_kcpm_libraries)"



### phraselibs
set --local 'phraselibsCommands' install check create copy-to-drive validate
complete --no-files -c 'kcpm' --condition "__fish_kcpm_needs_command" --arguments 'phraselibs' -d "Manage your phrase sample libraries."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command phraselibs; and not __fish_seen_subcommand_from $phraselibsCommands" --arguments 'install'       -d "Install (parts) of a phrase sample library."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command phraselibs; and not __fish_seen_subcommand_from $phraselibsCommands" --arguments 'upload'        -d "Upload samples from a phrase sample library."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command phraselibs; and not __fish_seen_subcommand_from $phraselibsCommands" --arguments 'status'        -d "Print outdated/changed status flags for a phrase sample library."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command phraselibs; and __fish_seen_subcommand_from install"        --long 'single'      --require-parameter --arguments "(__fish_kcpm_phraselibs)"    -d "Install a single song-instrument or all instruments for a song by providing either 'install <lib> 13A/Fl1' as argument or 'install <lib> 13A/.' using the period as a wildcard for all instruments."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command phraselibs; and __fish_seen_subcommand_from install"        --long 'newer'       --require-parameter --arguments "(__fish_kcpm_phraselibs)"    -d "Install all missing or updated phrase song-instruments."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command phraselibs; and __fish_seen_subcommand_from install"        --long 'missing'     --require-parameter --arguments "(__fish_kcpm_phraselibs)"    -d "Install all missing song-instruments."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command phraselibs; and __fish_seen_subcommand_from install"        --long 'all'         --require-parameter --arguments "(__fish_kcpm_phraselibs)"    -d "Install entire phrase sample library."
complete --no-files -c 'kcpm' --condition "__fish_kcpm_using_command phraselibs; and __fish_seen_subcommand_from install"        --long 'setup-only'  --require-parameter --arguments "(__fish_kcpm_phraselibs)"    -d "Setup phrase sample library without downloading any sample data."

complete --command 'kcpm' --no-files --arguments '(
    set --global __fish_kcpm_at_root true
    set --global __fish_kcpm_subcommand ""
    
    set --local cmd (commandline -opc)
    set --erase cmd[1]
    argparse --stop-nonopt (__fish_kcpm_global_optspecs) -- $cmd 2>/dev/null
    
    if set --query cmd[1]
        set __fish_kcpm_at_root false
    end
    
    if set --query cmd[1]
        set --local subcommand $cmd[1]
        set --global __fish_kcpm_subcommand "$subcommand"
    end
)'