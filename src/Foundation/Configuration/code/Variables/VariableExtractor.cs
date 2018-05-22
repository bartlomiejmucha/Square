using Square.Foundation.Configuration.Variables.Abstract;
using System;
using System.Collections.Generic;
using Sitecore.Diagnostics;

namespace Square.Foundation.Configuration.Variables
{
    public class VariableExtractor : IVariableExtractor
    {
        private string Prefix { get; set; }

        public VariableExtractor(string prefix)
        {
            Assert.IsNotNullOrEmpty(prefix, "Prefix");

            Prefix = prefix;
        }

        public Dictionary<string, string> Extract(string input)
        {
            var result = new Dictionary<string, string>();

            if (!string.IsNullOrWhiteSpace(Prefix) && !string.IsNullOrWhiteSpace(input))
            {
                var prefix = "$(" + Prefix + ":";

                for (var inputIndex = 0; inputIndex < input.Length;)
                {
                    var variableStartIndex = input.IndexOf(prefix, inputIndex, StringComparison.OrdinalIgnoreCase);
                    if (variableStartIndex < 0)
                    {
                        break;
                    }

                    var variableKeyIndex = variableStartIndex + prefix.Length;
                    var variableEndIndex = input.IndexOf(")", variableKeyIndex, StringComparison.OrdinalIgnoreCase);

                    if (variableStartIndex < 0 || variableEndIndex < 0)
                    {
                        break;
                    }

                    var variable = input.Substring(variableStartIndex, variableEndIndex - variableStartIndex + 1);
                    result[variable] = input.Substring(variableKeyIndex, variableEndIndex - variableKeyIndex);

                    inputIndex = variableEndIndex + 1;
                }
            }

            return result;
        }
    }
}