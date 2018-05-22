using Sitecore.Diagnostics;
using Square.Foundation.Configuration.Variables.Specialized;
using System.Xml;

namespace Square.Foundation.Configuration
{
    public class ConfigReader : Sitecore.Configuration.RuleBasedConfigReader
    {
        private ConnectionStringVariableReplacer _connectionStringVariableReplacer = new ConnectionStringVariableReplacer();
        private ApplicationSettingsVariableReplacer _applicationSettingsVariableReplacer = new ApplicationSettingsVariableReplacer();

        protected override XmlDocument DoGetConfiguration()
        {
            var xmlDocument = base.DoGetConfiguration();

            ReplaceVariables(xmlDocument.DocumentElement);

            return xmlDocument;
        }

        protected virtual void ReplaceVariables(XmlNode rootNode)
        {
            foreach (XmlAttribute attribute in rootNode.Attributes)
            {
                attribute.Value = _connectionStringVariableReplacer.Replace(attribute.Value);
                attribute.Value = _applicationSettingsVariableReplacer.Replace(attribute.Value);
            }

            foreach (XmlNode childNode in rootNode.ChildNodes)
            {
                if (childNode.NodeType == XmlNodeType.Element)
                {
                    ReplaceVariables(childNode);
                }
                
                if (!string.IsNullOrEmpty(childNode.Value))
                {
                    childNode.Value = _connectionStringVariableReplacer.Replace(childNode.Value);
                    childNode.Value = _applicationSettingsVariableReplacer.Replace(childNode.Value);
                }
            }
        }
    }
}