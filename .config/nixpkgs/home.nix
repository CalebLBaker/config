{ lib, pkgs, ... }:

{
    programs = {
        git = {
            enable = true;
            userEmail = "calebbaker774@gmail.com";
            userName = "CalebLBaker";
        };
        urxvt = {
            enable = true;
            scroll.bar.enable = false;
            extraConfig = {
                "*.foreground" = "white";
                "*.background" = "black";
            };
            fonts = [ "xft:Consolas:pixelSize=8" ];
        };
        zsh = {
            enable = true;
            enableCompletion = true;
            autocd = true;
            initExtra = "PROMPT='%~ %# '";
        };
        neovim = {
            enable = true;
            plugins = with pkgs.vimPlugins; [
                LanguageClient-neovim
            ];
            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;

            extraConfig = ''
              packadd termdebug
              let g:LanguageClient_serverCommands = { 'cpp': ['clangd'], 'rust': ['rls'] }
              nnoremap gd :call LanguageClient#textDocument_definition()<CR>
              nnoremap <F2> :call LanguageClient#textDocument_rename()<CR>
              nnoremap <C-g> :call LanguageClient#textDocument_references()<CR>
              inoremap <C-f> <C-x><C-o>
              tnoremap <ESC> <C-\><C-n>
              inoremap <C-l> ->
              nnoremap <C-j> :m+<CR>
              nnoremap <C-k> :m-2<CR>
              nnoremap <C-n> :noh<CR>
              set tabstop=4
              set shiftwidth=4
              set smartindent
              set autoindent
              set expandtab
              set mouse=a
              set hlsearch
              set linebreak
              set breakindent
              set breakindentopt=shift:2
              set number relativenumber
              set colorcolumn=120
              set spelllang=en
              autocmd FileType text,tex,latex,plaintex setlocal spell
              set scrolloff=8
            '';

        };
    };
    xsession = {
        windowManager.i3 = {
            enable = true;
            config = {
                keybindings = let modifier = "Mod4"; in lib.mkOptionDefault {
                    "${modifier}+g" = "split h";
                    "${modifier}+h" = "focus left";
                    "${modifier}+j" = "focus down";
                    "${modifier}+k" = "focus up";
                    "${modifier}+l" = "focus right";
                    "${modifier}+c" = "exec firefox";
                    XF86AudioRaiseVolume = "exec --no-startup-id pactl set-sink-volume 0 +5%";
                    XF86AudioLowerVolume = "exec --no-startup-id pactl set-sink-volume 0 -5%";
                    XF86AudioMute = "exec --no-startup-id pactl set-sink-mute 0 toggle";
                    XF86MonBrightnessUp = "exec brightnessctl s +5%";
                    XF86MonBrightnessDown = "exec brightnessctl s 5%-";
                };
                modes = {
                    resize = {
                        h = "resize grow width 10px or 10 ppt";
                        j = "resize shrink height 10px or 10 ppt";
                        k = "resize grow height 10px or 10 ppt";
                        l = "resize shrink width 10px or 10 ppt";
                        Return = ''mode "default"'';
                        Escape = ''mode "default"'';
                        "$mod+r" = ''mode "default"'';
                    };
                };
                modifier = "Mod4";
                window.titlebar = false;
                workspaceAutoBackAndForth = true;
            };
        };
    };
}

