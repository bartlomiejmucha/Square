namespace Square.Foundation.Configuration.Variables.Specialized
{
    public class ApplicationSettingsVariableReplacer : VariableReplacer
    {
        private const string VariablePrefix = "as";

        public ApplicationSettingsVariableReplacer() : base(new VariableExtractor(VariablePrefix), new ApplicationSettingsValueProvider())
        {
        }
    }
}