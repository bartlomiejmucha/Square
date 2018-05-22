using System.Configuration;
using Square.Foundation.Configuration.Variables.Abstract;

namespace Square.Foundation.Configuration.Variables
{
    public class ApplicationSettingsValueProvider : IValueProvider
    {
        public string GetValue(string key)
        {
            return ConfigurationManager.AppSettings[key];
        }
    }
}