using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLTrabajador;
using System.Data;

public partial class Pages_ListarTrabajadoresActivos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
       {
            lkbNuevo.OnClientClick = "javascript:window.location.replace('IngresarTrabajador.aspx?idTrabajador=0'); return false";
            gvResultado.DataSource = CargarBusqueda();
            gvResultado.DataBind();
        }



    }

    private List<ListarTrabajador> CargarBusqueda()
    {
        //Cargar Trabajadores Activos
        List<ListarTrabajador> listaBusqueda = new List<ListarTrabajador>();
        TrabajadorBL oTipoTrab = new TrabajadorBL();

        foreach (DataRow row in oTipoTrab.getTrabajadoresActivos().Rows)
        {
            ListarTrabajador lTrabajador = new ListarTrabajador();
            lTrabajador.Codigo = row["idTrabajador"].ToString();
            lTrabajador.Nombre = row["ApellidoPaterno"].ToString() + " " + row["apellidoMaterno"].ToString() + " " + row["Nombre"].ToString();
            lTrabajador.Cargo = row["Cargo"].ToString();
            lTrabajador.TipoTrabajador = row["TipoTrabajador"].ToString();
            lTrabajador.Link = "IngresarTrabajador.aspx?idTrabajador=" + row["idTrabajador"].ToString();
            lTrabajador.Modificar = "Modificar";
            listaBusqueda.Add(lTrabajador);
        }
        
        
        oTipoTrab = null;
        return listaBusqueda;
       
    }
    protected void gvResultado_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvResultado.PageIndex = e.NewPageIndex;
        gvResultado.DataSource = CargarBusqueda();
        gvResultado.DataBind();
    }


    public class ListarTrabajador
    {
        public string Codigo
        {

            get;
            set;

        }
        public string Nombre
        {
            get;
            set;

        }


        public string Cargo
        {
            get;
            set;
        }

        public string TipoTrabajador
        {
            get;
            set;

        }


        public string Link
        {
            get;
            set;
        }

        public string Modificar
        {
            get;
            set;
        }



    }
}