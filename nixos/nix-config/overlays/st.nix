self: super:
{
   st = super.st.override {
     patches = builtins.map super.fetchurl [
     {
       url = "https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff";
       sha256 = "9c5b4b4f23de80de78ca5ec3739dc6ce5e7f72666186cf4a9c6b614ac90fb285";
     }
     {
       url = "https://st.suckless.org/patches/clipboard/st-clipboard-0.8.3.diff";
       sha256 = "0f5ce33953abce74a9da3088ea35bf067a9a4cfeb9fe6ea9800268ce69e436c0";
     }
     {
       url = "https://st.suckless.org/patches/font2/st-font2-20190416-ba72400.diff";
       sha256 = "7279c787dba23d72a8a0a4613c0917e03d0087f0254f56a530cd9c521857d20b";
     }
     {
       url = "https://st.suckless.org/patches/xresources/st-xresources-20190105-3be4cf1.diff";
       sha256 = "71c55b796beebecb5e268405f369122fa5a8cf22d992725f00c6c88fe5895f84";
     }
     ];
     # conf = builtins.readFile ../resources/st/config.h;
   };
}
