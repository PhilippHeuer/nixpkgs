{ buildDotnetGlobalTool, lib }:

buildDotnetGlobalTool {
  pname = "Microsoft.CST.ApplicationInspector.CLI";
  version = "1.9.30";

  nugetHash = "sha256-fYWP3ZblYkOqyG0a8BRyy6GdRIk0PkdBmSgIxe3BfTo=";
  executables = [ "appinspector" ];

  meta = {
    description = "A source code analyzer built for surfacing features of interest and other characteristics to answer the question 'What's in the code?' quickly using static analysis with a json based rules engine.";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    mainProgram = "appinspector";
  };
}
