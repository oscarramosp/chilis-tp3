using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BEPostulante;
using DAOPostulante;
using System.Data;


/// <summary>
/// Summary description for PostulanteBL
/// </summary>
namespace BLPostulante
{
    public class PostulanteBL
    {
        public PostulanteBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int InsertarPostulante(PostulanteBE Po)
        {
            int idPostulante = 0;
            PostulanteDAO oPostulante = new PostulanteDAO();

            idPostulante = oPostulante.InsertarPostulante(Po);
            
            return idPostulante;

        }

        public Boolean ActualizarPostulante(PostulanteBE Po)
        {
            PostulanteDAO oPostulante = new PostulanteDAO();
            if(oPostulante.ActualizarPostulante(Po)==true) return true;
            else return false;

        }

        public DataTable getPostulante(int idPostulante) {

            PostulanteDAO oPostulante = new PostulanteDAO();
            return oPostulante.getPostulante(idPostulante);
        }
    }
}