using System.Configuration;
using Square.Foundation.Configuration.Variables.Abstract;

namespace Square.Foundation.Configuration.Variables
{
    public class ConnectionStringsValueProvider : IValueProvider
    {
        public string GetValue(string key)
        {
            return ConfigurationManager.ConnectionStrings[key]?.ConnectionString;
        }
    }
}