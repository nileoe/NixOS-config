{
  config,
  pkgs,
  ...
}: {
  xdg.desktopEntries.llm = {
    name = "llm";
    exec = "zen --new-window https://gemini.google.com/";
    terminal = false;
    categories = ["Application" "Network" "WebBrowser"];
    mimeType = ["text/html" "text/xml"];
  };
}
