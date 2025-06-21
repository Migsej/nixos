{ pkgs, ... }:

{
  programs.kakoune = {
    enable = true;
    plugins = with pkgs; [
      universal-ctags
      kakounePlugins.kak-ansi
    ];
    extraConfig = ''
      hook global BufWritePost .*[.]tex %{nop %sh{pdflatex -shell-escape $kak_buffile }}
      hook global BufCreate .*\.(inc)$ %{
        set-option buffer filetype gas
      }

      hook global InsertChar k %{ try %{
        exec -draft hH <a-k>jk<ret> d
        exec <esc>
      }}
      hook global NormalKey y|d|c %{ nop %sh{
        printf %s "$kak_main_reg_dquote" | xclip -in -selection clipboard >&- 2>&-
      }}

      hook global InsertChar '\}' %{
        try %{
          execute-keys -draft "<esc>x<a-k>\\begin\{\w+\}<ret>"
          execute-keys "<esc>xyp<a-f>\<semicolon>ecendO<backspace><esc>O<esc>i"
        }
      }

      add-highlighter global/ show-matching -previous
      hook global WinSetOption filetype=python %{
        jedi-enable-autocomplete
      }
      colorscheme tomorrow-night
'';
    config = {
      ui.assistant = "cat";
      tabStop = 2;
      indentWidth = 2;
      numberLines = {
        enable = true;
        relative = true;
      };
      wrapLines = {
        enable = true;
        word = true;
      };
      scrollOff = {
        columns = 0;
        lines = 10;
      };
      hooks = [
        {
          name = "InsertChar";
          option = "\\t";
          once = false;
          commands = "exec -draft -itersel h@";
        }
      ];
      keyMappings = [
        {
          docstring = "go to grep match";
          mode = "user";
          key = "g";
          effect = ":grep-jump<ret>";
        }
        {
         docstring = "yank the selection into the clipboard";
         mode = "user";
         key = "y";
         effect = "<a-|> xclip -selection clipboard<ret>";
        }
        {
         docstring = "paste from the clipboard";
         mode = "user";
         key = "p";
         effect = "!xclip -selection clipboard -o<ret>";
        }
      ];
    };
  };
}
