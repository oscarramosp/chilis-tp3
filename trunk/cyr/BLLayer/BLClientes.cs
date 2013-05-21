using System;
using System.Data;
using System.Data.Common;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System.Linq;
using System.Text;
using BELayer;
using DALayer;

namespace BLLayer
{
    public class BLClientes
    {
        public List<BECliente> selectClientes(BECliente oCliente)
        {
            List<BECliente> oListaClientes = new List<BECliente>();

            try
            {
                DAClientes oDAClientes = new DAClientes();
                oListaClientes = oDAClientes.selectClientes(oCliente);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaClientes;
        }

        public int eliminarCliente(BECliente oCliente)
        {
            DAClientes oDAClientes = new DAClientes();
            oDAClientes.mIniciarTransaccion();
            int codigoRetorno = 0;

            try
            {
                if (oDAClientes.validarEliminarCliente(oCliente) == 0)
                {
                    oDAClientes.eliminarCliente(oCliente, oDAClientes.mtransaction);
                    codigoRetorno = (int)BLLayer.Constantes.CodigoEliminacion.Eliminado;
                }
                else
                {
                    oCliente.Estado = "I";
                    oDAClientes.actualizarEstadoCliente(oCliente, oDAClientes.mtransaction);
                    codigoRetorno = (int)BLLayer.Constantes.CodigoEliminacion.Inactivado;
                }

                oDAClientes.mCommitTransaccion();                
            }
            catch (Exception ex)
            {
                oDAClientes.mRollbackTransaccion();
                ExceptionPolicy.HandleException(ex, "Exception Policy");
                codigoRetorno = (int)BLLayer.Constantes.CodigoEliminacion.Error;
            }
            return codigoRetorno;
        }

        public List<BEDireccionCliente> selectDireccionesxCliente(BECliente oCliente)
        {
            List<BEDireccionCliente> oListaDirecciones = new List<BEDireccionCliente>();

            try
            {
                DAClientes oDAClientes = new DAClientes();
                oListaDirecciones = oDAClientes.selectDireccionesxCliente(oCliente);
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }

            return oListaDirecciones;
        }

        public DTOResultado grabarCliente(BECliente oCliente)
        {
            DAClientes oDAClientes = new DAClientes();
            DTOResultado oResultado = new DTOResultado();


            try
            {
                Int32 intValidacion = oDAClientes.validarGrabarCliente(oCliente);
                if (intValidacion != (int)Constantes.CodigoGrabarCliente.Ok)
                {
                    oResultado.Codigo = (int)Constantes.CodigoGrabarCliente.DocumentoExiste;
                    oResultado.Objeto = oCliente;
                    return oResultado;
                }
            }
            catch (Exception ex)
            {
                ExceptionPolicy.HandleException(ex, "Exception Policy");
            }


            oDAClientes.mIniciarTransaccion();

            try
            {
                int codigoCliente = oDAClientes.grabarCliente(oCliente, oDAClientes.mtransaction);
                int codigoDireccion = 0;

                oDAClientes.eliminarDireccionCliente(oCliente, oDAClientes.mtransaction);

                for (int i = 0; i < oCliente.Direcciones.Count; i++)
			    {
                    // I DIDN'T MEAN TO, THEY FORCED ME TO WRITE THIS AGAINST MY WILL
                    oCliente.Direcciones[i].CodigoDireccion = 0; 
                    codigoDireccion = oDAClientes.grabarDireccionCliente(codigoCliente, oCliente.Direcciones[i], oDAClientes.mtransaction);
                    oCliente.Direcciones[i].CodigoDireccion = codigoDireccion;
			    }

                oDAClientes.mCommitTransaccion();

                oCliente.CodigoCliente = codigoCliente;

                oResultado.Codigo = (int)Constantes.CodigoGrabarCliente.Ok;
                oResultado.Objeto = oCliente;
                return oResultado;
            }
            catch (Exception ex)
            {
                oDAClientes.mRollbackTransaccion();
                ExceptionPolicy.HandleException(ex, "Exception Policy");
                return null;
            }
        }
    }
}
