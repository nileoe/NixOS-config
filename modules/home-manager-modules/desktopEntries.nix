{
  config,
  pkgs,
  ...
}: {
  firefox = {
    name = "paprika";
    genericName = "Web Browser";
    exec = "firefox %U";
    terminal = false;
    categories = ["Application" "Network" "WebBrowser"];
    mimeType = ["text/html" "text/xml"];
  };
}
