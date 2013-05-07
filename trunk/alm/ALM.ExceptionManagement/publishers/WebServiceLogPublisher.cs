using System;
using ALM.ExceptionManagement.LoggerManager;

namespace ALM.ExceptionManagement
{
	public class WebServiceLogPublisher : IExceptionXmlPublisher
	{
		void IExceptionXmlPublisher.Publish(System.Xml.XmlDocument exceptionInfo, System.Collections.Specialized.NameValueCollection configSettings)
		{
			try
			{
				ALM.ExceptionManagement.LoggerManager.LoggerManager ObjMgr = new ALM.ExceptionManagement.LoggerManager.LoggerManager();
				string strValue = @"<SCDCExceptions xmlns=""http://tempuri.org/SCDC.Log.xsd"">" + 
					exceptionInfo.InnerXml +  "</SCDCExceptions>";
				ObjMgr.RecordLog( strValue );
			}
			catch {}
		}
	}
}