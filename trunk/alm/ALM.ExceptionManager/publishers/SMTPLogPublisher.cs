using System;
using System.Net.Mail;
using System.Collections.Specialized;
using System.Text;
using ALM.ExceptionManagement;
using System.Net;

namespace ALM.ExceptionManagement
{
	class SMTPLogPublisher:IExceptionPublisher
	{
		#region IExceptionPublisher Members

		public void Publish(Exception exception, System.Collections.Specialized.NameValueCollection additionalInfo, System.Collections.Specialized.NameValueCollection configSettings)
		{
			try
			{
				string strNewLine = System.Environment.NewLine;
				StringBuilder stbException = new StringBuilder();

				MailAddress from = new MailAddress(configSettings["fromemail"].ToString());
                MailAddress to = new MailAddress(configSettings["toemail"].ToString().Replace(",", ";"));
                MailMessage objMessage = new MailMessage(from, to);
				objMessage.Subject = configSettings["subject"].ToString();
				for (int index = 0;index < additionalInfo.Count;index++)
				{
					stbException.Append(string.Format("{0}: {1}", additionalInfo.Keys[index], additionalInfo[index]));
					stbException.Append(strNewLine);
				}
				stbException.Append("ExceptionType: ");
				stbException.Append(exception.GetType());
				stbException.Append(strNewLine);
				stbException.Append("Message: ");
				stbException.Append(exception.Message);
				stbException.Append(strNewLine);
				stbException.Append("Target Site: ");
				stbException.Append(exception.TargetSite);
				stbException.Append(strNewLine);
				stbException.Append("Source: ");
				stbException.Append(exception.Source);
				stbException.Append(strNewLine);
				stbException.Append("StackTrace: ");
				stbException.Append(exception.StackTrace);
				stbException.Append(strNewLine);
				stbException.Append("InnerException: ");
				stbException.Append(exception.InnerException);
				stbException.Append(strNewLine);
				objMessage.Body = stbException.ToString();

                SmtpClient SmtpMail = new SmtpClient(Convert.ToString(configSettings["smtpServer"]));
                //SmtpMail.Credentials = CredentialCache.DefaultNetworkCredentials;
                SmtpMail.Credentials = new System.Net.NetworkCredential(Convert.ToString(configSettings["userSMTP"]), Convert.ToString(configSettings["passwordSMTP"]));
                SmtpMail.Send(objMessage);
  			}
			catch (Exception)
			{}
		}
		#endregion
	}
}