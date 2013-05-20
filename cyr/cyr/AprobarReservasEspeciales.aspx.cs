using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Net.Mail;
using BLLayer;
using BELayer;

namespace cyr
{
    public partial class AprobarReservasEspeciales : System.Web.UI.Page
    {

        BLReservas oBLReservas = new BLReservas();

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AprobarReservasEspeciales), this.Page);

            if (!IsPostBack)
            {
                listarReservasEspeciales();
            }

        }

        private void listarReservasEspeciales()
        {
            //BEReserva bReserva = new BEReserva();
            List<BEReserva> oListaReserva = oBLReservas.selectReservasEspeciales();
            if (oListaReserva.Count == 0)
            {
                lblSinResultados.Visible = true;
                lblSinResultados.Text = "No se encontraron reservas pendientes";
                dgvReservaEspecial.DataSource = null;
                dgvReservaEspecial.DataBind();
            }
            else
            {
                //Session["lstBusquedaReserva"] = oListaReserva;
                
                dgvReservaEspecial.DataSource = oListaReserva;
                dgvReservaEspecial.DataBind();
                lblSinResultados.Visible = false;
                lblSinResultados.Text = String.Empty;
            }
        }



        protected void btnAprobar_Click(object sender, EventArgs e)
        {
            lblSinResultados.Text = string.Empty;
            aprobarFechasEspeciales();
        }

        public void aprobarFechasEspeciales()
        {
            int cont = 0;
            string mensaje = string.Empty;
            lblResultadoCorreo.Text = string.Empty;
            foreach (GridViewRow gvRow in dgvReservaEspecial.Rows)
            {
                var chk = gvRow.FindControl("chk") as CheckBox;
                string ESTADO;
          

                if (chk.Checked)
                {
                    var lblcodigo = gvRow.FindControl("lblCodigo") as Label;
                    var lblestado = gvRow.FindControl("lblEstado") as Label;
                    var lblemail = gvRow.FindControl("lblemail") as Label;
                    var lblnombres = gvRow.FindControl("lblNombres") as Label;
                    var lblfecha = gvRow.FindControl("lblFecha") as Label;
                    ESTADO = lblestado.Text;
                    cont += 1;

                    if (ESTADO.Equals("APROBADO") || ESTADO.Equals("RECHAZADO"))
                    {
                        mensaje = "Seleccionar reservas en estado PENDIENTE";
                    }
                    else
                    {
                        int codigo = Convert.ToInt32(lblcodigo.Text);
                        BEReserva oReserva = new BEReserva();
                        oReserva.CodigoReserva = codigo;
                        oReserva.Estado = "A";

                        int codigoAprobado = oBLReservas.aprobarReserva(oReserva);
                        string email = lblemail.Text;
                       
                        string nombres = lblnombres.Text;
                        string fecha = lblfecha.Text;

                        switch (codigoAprobado)
                        {
                            case (int)BLLayer.Constantes.CodigoAprobacion.aprobado:
                                EnvioCorreo(email, nombres, fecha, "APROBADO");       
                                mensaje = "Se aprobaron las reservas de fechas especiales ";
                                lblResultadoCorreo.Visible = true;
                                lblResultadoCorreo.Text = "Se realizó el envio de correo al cliente";
                                break;

                            case (int)BLLayer.Constantes.CodigoAprobacion.Error:
                                mensaje = "Ocurrió un error en la aprobacion de las reservas";
                                break;
                        }

                    }

                }
               
      
            }

            listarReservasEspeciales();

         
            if (cont == 0)
            {
                lblSinResultados.Text = "No ha seleccionado Ningun registro";
                lblSinResultados.Visible = true;
            }else
            {
             resultados(mensaje);
            }
        }

        protected void btnRechazar_Click(object sender, EventArgs e)
        {
            lblSinResultados.Text = string.Empty;
            rechazarFechasEspeciales();
        }

        public void rechazarFechasEspeciales()
        {
            int cont = 0;
            string mensaje = string.Empty;
            lblResultadoCorreo.Text  = string.Empty;
            foreach (GridViewRow gvRow in dgvReservaEspecial.Rows)
            {
                var chk = gvRow.FindControl("chk") as CheckBox;
                string ESTADO;

                if (chk.Checked)
                {
                    var lblcodigo = gvRow.FindControl("lblCodigo") as Label;
                    var lblestado = gvRow.FindControl("lblEstado") as Label;
                    var lblemail = gvRow.FindControl("lblemail") as Label ;
                    var lblnombres = gvRow.FindControl("lblNombres") as Label;
                    var lblfecha = gvRow.FindControl("lblFecha") as Label;
                    ESTADO = lblestado.Text;

                    cont += 1;
                    if (ESTADO.Equals("APROBADO") || ESTADO.Equals("RECHAZADO"))
                    {
                     
                       mensaje = "Seleccionar reservas en estado PENDIENTE";
                    }
                    else
                    {
                        int codigo = Convert.ToInt32(lblcodigo.Text);
                        string email=lblemail.Text ;
                        string nombres = lblnombres.Text;
                        string fecha = lblfecha.Text;
                     
                        BEReserva oReserva = new BEReserva();
                        oReserva.CodigoReserva = codigo;
                        oReserva.Estado = "R";

                        int codigoAprobado = oBLReservas.aprobarReserva(oReserva);
                      

                        switch (codigoAprobado)
                        {
                            case (int)BLLayer.Constantes.CodigoAprobacion.aprobado:
                                EnvioCorreo(email, nombres,fecha,"RECHAZADO" );
                                //listarReservasEspeciales();
                                mensaje = "Se rechazaron las reservas de fechas especiales";
                                lblResultadoCorreo.Visible = true;
                                lblResultadoCorreo.Text = "Se realizó el envio de correo al cliente";
                                break;

                            case (int)BLLayer.Constantes.CodigoAprobacion.Error:
                                mensaje = "Ocurrió un error en el proceso de rechazo de las reservas";
                                break;
                        }

                        resultados(mensaje);

                    }

                }

            }
            listarReservasEspeciales();
            if (cont == 0)
            {
                lblSinResultados.Text = "No ha seleccionado Ningun registro";
                lblSinResultados.Visible = true;
            }
            else
            {
                resultados(mensaje);
            }
        }

        public void resultados(string mensaje)
        {
            
            lblSinResultados.Visible = true;
            lblSinResultados.Text = mensaje;
          
    

        }

        protected void dgvReservaEspecial_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void dgvReservaEspecial_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        public void EnvioCorreo(string email,string nombres,string fecha, string estado)
        {
            System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();
            msg.To.Add(email);
            msg.From = new MailAddress("atencionalclientechilis@gmail.com", "CHILIS", System.Text.Encoding.UTF8);
            msg.Subject = "Asunto";
            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            msg.Body = "Estimado Sr(a) " + nombres + ":" + "\r" +
                 " Se le comunica que su reserva del dia " + fecha + " ha sido " + estado ;
            msg.BodyEncoding = System.Text.Encoding.UTF8;
            msg.IsBodyHtml = false;

            SmtpClient client = new SmtpClient();
            client.Credentials = new System.Net.NetworkCredential("atencionalclientechilis@gmail.com", "chilis1234");
            client.Port = 587;
            client.Host = "smtp.gmail.com";
            client.EnableSsl = true;
            try
            {
                client.Send(msg);
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                Console.WriteLine(ex.Message);
                Console.ReadLine();
            }
        }


    }
}
