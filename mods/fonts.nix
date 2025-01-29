{ config, pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [  
    corefonts  
    vistafonts  
    noto-fonts  

    # cjk fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif  
    noto-fonts-emoji  
    vistafonts-cht
    source-han-serif
    source-han-sans-vf-otf
    source-han-sans-vf-ttf
    source-han-mono

    # coding/terminal fonts
    liberation_ttf  
    fira-code  
    fira-code-symbols  
    mplus-outline-fonts.githubRelease  
    dina-font  
    proggyfonts
    iosevka
    nerdfonts
  ];

  fonts.fontDir.enable = true;
}
