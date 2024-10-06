{ pkgs, ... }:

{
  xdg.configFile."kak-lsp/kak-lsp.toml".source = ./dotfiles/kak-lsp.toml;
  programs.kakoune = {
    enable = true;
    plugins = with pkgs; [
      kakounePlugins.kakoune-lsp
      rust-analyzer
      rocmPackages_5.llvm.clang-tools-extra
      texlab
    ];
    extraConfig = ''
      map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
      map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'

      map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
      map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
      map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
      map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
      map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
      map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'
      eval %sh{kak-lsp --kakoune --session $kak_session}
      lsp-enable
    '';
    config = {
      ui.assistant = "cat";
      colorScheme = "palenight";
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
