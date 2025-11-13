{ userSettings, ... }:

{

  programs.librewolf = {
    enable = true;

    profiles = {
      ${userSettings.username} = {
        id = 0;
        name = userSettings.name;
        isDefault = true;
        extensions.force = true;
        settings = {
          "sidebar.visibility" = "expand-on-hover";
          "sidebar.main.tools" = ""; # Doesn't work
        };
      };
    };

    # Can't be set by policy
    settings = {
      "middlemouse.paste" = false;
      # Side Bar
      "sidebar.verticalTabs" = true;
      "sidebar.position_start" = false;
      "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
    };

    policies = {
      DefaultDownloadDirectory = "/home/${userSettings.username}/Desktop";
      Preferences = {
        # General
        "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
        "browser.newtabpage.enabled" = false;
        "browser.download.always_ask_before_handling_new_types" = true;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "browser.translations.enable" = false;
        "general.autoScroll" = true;
        "browser.toolbars.bookmarks.visibility" = "newtab";
        # userChrome.css customisation
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Stop alt key from spawning menu bar
        "ui.key.menuAccessKeyFocuses" = false;
        # Play DRM-controlled content
        "media.eme.enabled" = true;
        # Container Tabs
        "privacy.userContext.enabled" = false;
        # Dark Mode
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        # Search Suggestions
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.uiCustomization.state" = builtins.toJSON {
          "placements" = {
            "unified-extensions-area" = [
              "ublock0_raymondhill_net-browser-action"                        # uBlock Origin
              "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"         # Vimium
              "_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action"         # Yomitan
              "keepassxc-browser_keepassxc_org-browser-action"                # KeePassXC
              "_cb31ec5d-c49a-4e5a-b240-16c767444f62_-browser-action"         # Translate
              "enhancerforyoutube_maximerf_addons_mozilla_org-browser-action" # YT Enhancer
              "_cb31ec5d-c49a-4e5a-b240-16c767444f62_-browser-action"         # Indie Wiki
              "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"         # Stylus
              "firefoxcolor_mozilla_com-browser-action"                       # Firefox Colour
              "_6b733b82-9261-47ee-a595-2dda294a4d08_-browser-action"         # Jisho Pitcher
            ];
            "nav-bar" = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "unified-extensions-button"
              "sidebar-button"
            ];
          };
          "currentVersion" = 23; # Required to work
        };
        # Borealis
        "browser.fixup.domainsuffixwhitelist.borealis" = true;
      };
      ExtensionSettings = {
        "{6b733b82-9261-47ee-a595-2dda294a4d08}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/yomitan/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        # MANUAL: Options -> CSS for Vimium UI -> Paste
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "enhancerforyoutube@maximerf.addons.mozilla.org" = {
          install_url = "https://www.mrfdev.com/downloads/enhancer_for_youtube-2.0.130.1.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/indie-wiki-buddy/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        # "browser-mon@xdman.sourceforge.net" = {
        #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/xdm-browser-monitor/latest.xpi";
        #   installation_mode = "force_installed";
        #   private_browsing = true;
        # };
        "{61dff19a-4460-42de-9825-1ed4f0813091}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/pitcher/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        # MANUAL: Import catppuccin.json to Stylus
        "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        # Catppuccin and Stylix Module
        "FirefoxColor@mozilla.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };

  # userChrome Customisations
  home.file.".librewolf/${userSettings.username}" = {
    source = ./userChrome;
    recursive = true;
  };

}

