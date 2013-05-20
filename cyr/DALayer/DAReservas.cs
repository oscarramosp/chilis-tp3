using System;
using System.Collections.Generic;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System.Data;

namespace DALayer
{
    public class DAReservas : DABase
    {
        public int grabarReserva(BEReserva oReserva, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_GRABAR_RESERVA");

            IDbDataParameter myParam = dbCommandWrapper.Command.CreateParameter();
            myParam.DbType = DbType.Int32;
            myParam.ParameterName = "@IN_CODIGO_RESERVA";
            myParam.Direction = ParameterDirection.InputOutput;
            myParam.Value = oReserva.CodigoReserva;
            dbCommandWrapper.Command.Parameters.Add(myParam);

            dbCommandWrapper.AddInParameter("@DT_FECHA_RESERVA", DbType.DateTime, oReserva.FechaReserva);
            dbCommandWrapper.AddInParameter("@VC_HORA_INICIO", DbType.String, oReserva.HoraInicio);
            dbCommandWrapper.AddInParameter("@VC_HORA_FIN", DbType.String, oReserva.HoraFin);
            dbCommandWrapper.AddInParameter("@IN_CANTIDAD_PERSONAS", DbType.Int32, oReserva.CantidadPersonas);
            dbCommandWrapper.AddInParameter("@VC_OBSERVACION", DbType.String, oReserva.Observacion);
            dbCommandWrapper.AddInParameter("@CH_ESTADO", DbType.String, oReserva.Estado);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_MESA", DbType.Int32, oReserva.Mesa.CodigoMesa);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, oReserva.Cliente.CodigoCliente);
            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);

            int codigoReserva = Convert.ToInt32(myParam.Value);

            return codigoReserva;
        }

        public List<BEReserva> selectReserva(BEReserva oReserva)
        {
            List<BEReserva> oListaReserva = new List<BEReserva>();
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_RESERVAS");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_RESERVA", DbType.Int32, oReserva.CodigoReserva);
            dbCommandWrapper.AddInParameter("@DT_FECHA_RESERVA", DbType.DateTime, oReserva.FechaReserva);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_MESA", DbType.Int32, oReserva.Mesa.CodigoMesa);
            
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {
                oReserva = new BEReserva(rdr);
                oReserva.CodigoReserva = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_RESERVA")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_RESERVA"));
                oReserva.FechaReserva = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA_RESERVA")) ? (DateTime?)null : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA_RESERVA"));
                oReserva.HoraInicio = rdr.IsDBNull(rdr.GetOrdinal("VC_HORA_INICIO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_HORA_INICIO"));
                oReserva.HoraFin = rdr.IsDBNull(rdr.GetOrdinal("VC_HORA_FIN")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_HORA_FIN"));
                oReserva.CantidadPersonas = rdr.IsDBNull(rdr.GetOrdinal("IN_CANTIDAD_PERSONAS")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CANTIDAD_PERSONAS"));
                oReserva.Observacion = rdr.IsDBNull(rdr.GetOrdinal("VC_OBSERVACION")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_OBSERVACION"));
                oReserva.Estado = rdr.IsDBNull(rdr.GetOrdinal("CH_ESTADO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_ESTADO"));
                oReserva.Mesa = new BEMesa();
                oReserva.Mesa.CodigoMesa = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_MESA")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_MESA"));
                

                oReserva.Cliente = new BECliente(rdr);
                oReserva.Cliente.CodigoCliente = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_CLIENTE")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_CLIENTE"));
                oReserva.Cliente.Nombres = rdr.IsDBNull(rdr.GetOrdinal("VC_NOMBRES")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NOMBRES"));
                oReserva.Cliente.ApellidoPaterno = rdr.IsDBNull(rdr.GetOrdinal("VC_APELLIDO_PATERNO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_APELLIDO_PATERNO"));
                oReserva.Cliente.ApellidoMaterno = rdr.IsDBNull(rdr.GetOrdinal("VC_APELLIDO_MATERNO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_APELLIDO_MATERNO"));
                oReserva.Cliente.RazonSocial = rdr.IsDBNull(rdr.GetOrdinal("VC_RAZON_SOCIAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_RAZON_SOCIAL"));
                oReserva.Cliente.NumeroDocumento = rdr.IsDBNull(rdr.GetOrdinal("VC_NUMERO_DOCUMENTO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NUMERO_DOCUMENTO"));
                oReserva.Cliente.TipoDocumento.CodigoTipoDocumento = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_TIPO_DOCUMENTO")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_TIPO_DOCUMENTO"));
                oReserva.Cliente.TelefonoPrincipal = rdr.IsDBNull(rdr.GetOrdinal("VC_TELEFONO_PRINCIPAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_TELEFONO_PRINCIPAL"));
                oReserva.Cliente.TipoCliente = rdr.IsDBNull(rdr.GetOrdinal("CH_TIPO_CLIENTE")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_TIPO_CLIENTE"));

                oListaReserva.Add(oReserva);
            }
            return oListaReserva;
        }

        public void eliminarReserva(BEReserva oReserva, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_ELIMINAR_RESERVA");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_RESERVA", DbType.Int32, oReserva.CodigoReserva);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);
        }

        public Int32 validarFechaReserva(BEReserva oReserva)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_VALIDAR_FECHA_RESERVA");
            dbCommandWrapper.AddInParameter("@DT_FECHA_RESERVA", DbType.DateTime, oReserva.FechaReserva);
            dbCommandWrapper.AddInParameter("@VC_HORA_INICIO", DbType.String, oReserva.HoraInicio);
            dbCommandWrapper.AddInParameter("@VC_HORA_FIN", DbType.String, oReserva.HoraFin);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_MESA", DbType.Int32, oReserva.Mesa.CodigoMesa);

            return Convert.ToInt32(db.ExecuteScalar(dbCommandWrapper));
        }

        public List<BEReserva> selectReservasEspeciales()
        {
            BEReserva oReserva = new BEReserva();
            List<BEReserva> oListaReservas = new List<BEReserva>();
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_RESERVAS_ESPECIALES");
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {
                oReserva = new BEReserva(rdr);
                oReserva.CodigoReserva = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_RESERVA")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_RESERVA"));
                //oReserva.NombreCliente = rdr.IsDBNull(rdr.GetOrdinal("VC_RAZON_SOCIAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_RAZON_SOCIAL"));
                //oReserva.FechaReservaEspecial = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA_RESERVA_ESPECIAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("DT_FECHA_RESERVA_ESPECIAL"));
                oReserva.FechaReserva = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA_RESERVA")) ? (DateTime?)null : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA_RESERVA"));
                oReserva.HoraInicio = rdr.IsDBNull(rdr.GetOrdinal("VC_HORA_INICIO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_HORA_INICIO"));
                oReserva.CantidadHoras = rdr.IsDBNull(rdr.GetOrdinal("IN_CANTIDAD_HORAS")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CANTIDAD_HORAS"));
                oReserva.CantidadPersonas = rdr.IsDBNull(rdr.GetOrdinal("IN_CANTIDAD_PERSONAS")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CANTIDAD_PERSONAS"));
                oReserva.Observacion = rdr.IsDBNull(rdr.GetOrdinal("VC_OBSERVACION")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_OBSERVACION"));

                oReserva.Estado = rdr.IsDBNull(rdr.GetOrdinal("CH_ESTADO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_ESTADO"));

                oReserva.Cliente = new BECliente(rdr);
                oReserva.Cliente.RazonSocial = rdr.IsDBNull(rdr.GetOrdinal("VC_RAZON_SOCIAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_RAZON_SOCIAL"));
                oReserva.Cliente.Email = rdr.IsDBNull(rdr.GetOrdinal("VC_EMAIL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_EMAIL"));
                oReserva.Cliente.Nombres = rdr.IsDBNull(rdr.GetOrdinal("VC_NOMBRES")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NOMBRES"));

                 oListaReservas.Add(oReserva);
            }
            return oListaReservas;
        }

        public void aprobarReserva(BEReserva oReserva, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_APROBAR_RESERVA");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_RESERVA", DbType.Int32, oReserva.CodigoReserva);
            dbCommandWrapper.AddInParameter("@CH_ESTADO_CLIENTE", DbType.String, oReserva.Estado);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);
        }
        
    }
}
