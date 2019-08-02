# Defined in /home/nikita/.config/fish/functions/cde.fish @ line 1
function cde
    unload;
    cd (echo $argv);
    load
end
