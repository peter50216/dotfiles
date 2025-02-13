{specialArgs, ...}: {
  nixGL = {
    packages = specialArgs.nixGL;
    defaultWrapper = "mesa";
    installScripts = ["mesa"];
  };
}
