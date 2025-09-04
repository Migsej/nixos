config.load_autoconfig(False)

c.editor.command = ["st", "-e", "kak", "{}"]
config.bind("gk", "scroll-to-perc 0")
config.bind("gj", "scroll-to-perc 100")
config.bind("<Alt+n>", "search-prev")
c.aliases = {
  "bw": "spawn --userscript qute-bitwarden -d dmenu -p 'dmenu -p password' --auto-lock 0",
}

config.set("content.blocking.method", "both")
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "gg": "https://google.com/search?q={}",
    "ns": "https://search.nixos.org/packages?query={}",
}

c.content.notifications.enabled = False
c.content.register_protocol_handler = False

