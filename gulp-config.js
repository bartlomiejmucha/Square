module.exports = function () {
  var instanceRoot = "C:\\Websites\\Square";
  var config = {
    websiteRoot: instanceRoot + "\\sitecore",
    sitecoreLibraries: instanceRoot + "\\sitecore\\bin",
    licensePath: instanceRoot + "\\App_Data\\license.xml",
    solutionName: "Square",
    buildConfiguration: "Debug",
    buildToolsVersion: 15.0,
    buildMaxCpuCount: 0,
    buildVerbosity: "minimal",
    buildPlatform: "Any CPU",
    publishPlatform: "AnyCpu",
    runCleanBuilds: false
  };
  return config;
}
