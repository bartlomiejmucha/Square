using System.Collections.Generic;

namespace Square.Foundation.Configuration.Variables.Abstract
{
    public interface IVariableExtractor
    {
        Dictionary<string, string> Extract(string input);
    }
}