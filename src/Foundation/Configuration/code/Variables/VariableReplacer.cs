using Square.Foundation.Configuration.Variables.Abstract;

namespace Square.Foundation.Configuration.Variables
{
    public class VariableReplacer : IVariableReplacer
    {
        private readonly IVariableExtractor _variableExtractor;
        private readonly IValueProvider _valueProvider;

        public VariableReplacer(IVariableExtractor variableExtractor, IValueProvider valueProvider)
        {
            _variableExtractor = variableExtractor;
            _valueProvider = valueProvider;
        }

        public string Replace(string input)
        {
            if (!string.IsNullOrWhiteSpace(input))
            {
                foreach (var variable in _variableExtractor.Extract(input))
                {
                    var variableValue = _valueProvider.GetValue(variable.Value);
                    if (variableValue != null)
                    {
                        input = input.Replace(variable.Key, variableValue);
                    }
                }

                return input;
            }

            return input;
        }
    }
}