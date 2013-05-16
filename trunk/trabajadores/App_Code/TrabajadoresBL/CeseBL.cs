using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BECese;
using DAOCese;

/// <summary>
/// Summary description for CeseBL
/// </summary>
namespace BLCese
{
    public class CeseBL
    {
        public CeseBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public Boolean InsertarCese(CeseBE Cese)
        {
            CeseDAO oInsertarCese = new CeseDAO();
            return oInsertarCese.InsertarCese(Cese);

        }
    }
}