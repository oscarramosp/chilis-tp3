using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using BELayer;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;

namespace DALayer
{
    public class DAClientes : DABase
    {

        public List<BECliente> selectClientes(BECliente oCliente)
        {
            List<BECliente> oListaClientes = new List<BECliente>();
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_CLIENTES_BUSQUEDA");
            dbCommandWrapper.AddInParameter("@CH_TIPO_CLIENTE", DbType.String, oCliente.TipoCliente);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_TIPO_DOCUMENTO", DbType.Int32, oCliente.TipoDocumento.CodigoTipoDocumento);
            dbCommandWrapper.AddInParameter("@VC_NUMERO_DOCUMENTO", DbType.String, oCliente.NumeroDocumento);
            dbCommandWrapper.AddInParameter("@VC_RAZON_SOCIAL", DbType.String, oCliente.RazonSocial);
            dbCommandWrapper.AddInParameter("@CH_SEXO", DbType.String, oCliente.Sexo);
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {
                oCliente = new BECliente(rdr);
                oCliente.CodigoCliente = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_CLIENTE")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_CLIENTE"));
                oCliente.Nombres = rdr.IsDBNull(rdr.GetOrdinal("VC_NOMBRES")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NOMBRES"));
                oCliente.ApellidoPaterno = rdr.IsDBNull(rdr.GetOrdinal("VC_APELLIDO_PATERNO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_APELLIDO_PATERNO"));
                oCliente.ApellidoMaterno = rdr.IsDBNull(rdr.GetOrdinal("VC_APELLIDO_MATERNO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_APELLIDO_MATERNO"));
                oCliente.RazonSocial = rdr.IsDBNull(rdr.GetOrdinal("VC_RAZON_SOCIAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_RAZON_SOCIAL"));
                oCliente.NumeroDocumento = rdr.IsDBNull(rdr.GetOrdinal("VC_NUMERO_DOCUMENTO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_NUMERO_DOCUMENTO"));
                oCliente.FechaNacimiento = rdr.IsDBNull(rdr.GetOrdinal("DT_FECHA_NACIMIENTO")) ? new DateTime() : rdr.GetDateTime(rdr.GetOrdinal("DT_FECHA_NACIMIENTO"));
                oCliente.TipoDocumento.CodigoTipoDocumento = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_TIPO_DOCUMENTO")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_TIPO_DOCUMENTO"));
                oCliente.TipoDocumento.Acronimo = rdr.IsDBNull(rdr.GetOrdinal("VC_ACRONIMO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_ACRONIMO"));
                oCliente.CodigoClasificacion = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_CLASIFICACION")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_CLASIFICACION"));
                oCliente.Email = rdr.IsDBNull(rdr.GetOrdinal("VC_EMAIL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_EMAIL"));
                oCliente.Sexo = rdr.IsDBNull(rdr.GetOrdinal("CH_SEXO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_SEXO"));
                oCliente.TelefonoPrincipal = rdr.IsDBNull(rdr.GetOrdinal("VC_TELEFONO_PRINCIPAL")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_TELEFONO_PRINCIPAL"));
                oCliente.Contacto = rdr.IsDBNull(rdr.GetOrdinal("VC_CONTACTO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_CONTACTO"));
                oCliente.Estado = rdr.IsDBNull(rdr.GetOrdinal("CH_ESTADO_CLIENTE")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_ESTADO_CLIENTE"));
                oCliente.TipoCliente = rdr.IsDBNull(rdr.GetOrdinal("CH_TIPO_CLIENTE")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_TIPO_CLIENTE"));
                oListaClientes.Add(oCliente);
            }
            return oListaClientes;
        }

        public void actualizarEstadoCliente(BECliente oCliente, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_ACTUALIZAR_ESTADO_CLIENTE");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, oCliente.CodigoCliente);
            dbCommandWrapper.AddInParameter("@CH_ESTADO_CLIENTE", DbType.String, oCliente.Estado);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);
        }

        public void eliminarCliente(BECliente oCliente, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_ELIMINAR_CLIENTE");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, oCliente.CodigoCliente);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);
        }

        public Int32 validarEliminarCliente(BECliente oCliente)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_VALIDAR_ELIMINAR_CLIENTE");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, oCliente.CodigoCliente);

            return Convert.ToInt32(db.ExecuteScalar(dbCommandWrapper));
        }

        public List<BEDireccionCliente> selectDireccionesxCliente(BECliente oCliente)
        {
            List<BEDireccionCliente> oListaDirecciones = new List<BEDireccionCliente>();
            BEDireccionCliente oDireccionCliente;
            IDataReader rdr = null;
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_LISTAR_DIRECCIONES_CLIENTE");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, oCliente.CodigoCliente);
            rdr = db.ExecuteReader(dbCommandWrapper);
            while (rdr.Read())
            {
                oDireccionCliente = new BEDireccionCliente(rdr);
                oDireccionCliente.CodigoDireccion = rdr.IsDBNull(rdr.GetOrdinal("IN_CODIGO_DIRECCION")) ? 0 : rdr.GetInt32(rdr.GetOrdinal("IN_CODIGO_DIRECCION"));
                oDireccionCliente.Direccion = rdr.IsDBNull(rdr.GetOrdinal("VC_DIRECCION")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_DIRECCION"));
                oDireccionCliente.Referencia = rdr.IsDBNull(rdr.GetOrdinal("VC_REFERENCIA")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_REFERENCIA"));
                oDireccionCliente.Telefono = rdr.IsDBNull(rdr.GetOrdinal("VC_TELEFONO")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("VC_TELEFONO"));
                oDireccionCliente.TipoDireccion = rdr.IsDBNull(rdr.GetOrdinal("CH_TIPO_DIRECCION")) ? String.Empty : rdr.GetString(rdr.GetOrdinal("CH_TIPO_DIRECCION"));
                oListaDirecciones.Add(oDireccionCliente);
            }
            return oListaDirecciones;
        }

        public int grabarCliente(BECliente oCliente, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_GRABAR_CLIENTE");

            IDbDataParameter myParam = dbCommandWrapper.Command.CreateParameter(); 
            myParam.DbType = DbType.Int32; 
            myParam.ParameterName = "@IN_CODIGO_CLIENTE"; 
            myParam.Direction = ParameterDirection.InputOutput;
            myParam.Value = oCliente.CodigoCliente;
            dbCommandWrapper.Command.Parameters.Add(myParam);
            
            dbCommandWrapper.AddInParameter("@VC_NOMBRES", DbType.String, oCliente.Nombres);
            dbCommandWrapper.AddInParameter("@VC_APELLIDO_PATERNO", DbType.String, oCliente.ApellidoPaterno);
            dbCommandWrapper.AddInParameter("@VC_APELLIDO_MATERNO", DbType.String, oCliente.ApellidoMaterno);
            dbCommandWrapper.AddInParameter("@VC_RAZON_SOCIAL", DbType.String, oCliente.RazonSocial);
            dbCommandWrapper.AddInParameter("@VC_NUMERO_DOCUMENTO", DbType.String, oCliente.NumeroDocumento);
            dbCommandWrapper.AddInParameter("@DT_FECHA_NACIMIENTO", DbType.DateTime, oCliente.FechaNacimiento);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_TIPO_DOCUMENTO", DbType.Int32, oCliente.TipoDocumento.CodigoTipoDocumento);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLASIFICACION", DbType.Int32, oCliente.CodigoClasificacion);
            dbCommandWrapper.AddInParameter("@VC_EMAIL", DbType.String, oCliente.Email);
            dbCommandWrapper.AddInParameter("@CH_SEXO", DbType.String, oCliente.Sexo);
            dbCommandWrapper.AddInParameter("@VC_TELEFONO_PRINCIPAL", DbType.String, oCliente.TelefonoPrincipal);
            dbCommandWrapper.AddInParameter("@VC_CONTACTO", DbType.String, oCliente.Contacto);
            dbCommandWrapper.AddInParameter("@CH_ESTADO_CLIENTE", DbType.String, oCliente.Estado);
            dbCommandWrapper.AddInParameter("@CH_TIPO_CLIENTE", DbType.String, oCliente.TipoCliente);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);

            int codigoCliente = Convert.ToInt32(myParam.Value);

            return codigoCliente;
        }

        public Int32 validarGrabarCliente(BECliente oCliente)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_VALIDAR_GRABAR_CLIENTE");

            Int32 intCodigoError = 0;

            IDbDataParameter myParam = dbCommandWrapper.Command.CreateParameter();
            myParam.DbType = DbType.Int32;
            myParam.ParameterName = "@IN_CODIGO_ERROR";
            myParam.Direction = ParameterDirection.InputOutput;
            myParam.Value = intCodigoError;
            dbCommandWrapper.Command.Parameters.Add(myParam);

            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, oCliente.CodigoCliente);
            dbCommandWrapper.AddInParameter("@VC_NOMBRES", DbType.String, oCliente.Nombres);
            dbCommandWrapper.AddInParameter("@VC_APELLIDO_PATERNO", DbType.String, oCliente.ApellidoPaterno);
            dbCommandWrapper.AddInParameter("@VC_APELLIDO_MATERNO", DbType.String, oCliente.ApellidoMaterno);
            dbCommandWrapper.AddInParameter("@VC_RAZON_SOCIAL", DbType.String, oCliente.RazonSocial);
            dbCommandWrapper.AddInParameter("@VC_NUMERO_DOCUMENTO", DbType.String, oCliente.NumeroDocumento);
            dbCommandWrapper.AddInParameter("@DT_FECHA_NACIMIENTO", DbType.DateTime, oCliente.FechaNacimiento);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_TIPO_DOCUMENTO", DbType.Int32, oCliente.TipoDocumento.CodigoTipoDocumento);
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLASIFICACION", DbType.Int32, oCliente.CodigoClasificacion);
            dbCommandWrapper.AddInParameter("@VC_EMAIL", DbType.String, oCliente.Email);
            dbCommandWrapper.AddInParameter("@CH_SEXO", DbType.String, oCliente.Sexo);
            dbCommandWrapper.AddInParameter("@VC_TELEFONO_PRINCIPAL", DbType.String, oCliente.TelefonoPrincipal);
            dbCommandWrapper.AddInParameter("@VC_CONTACTO", DbType.String, oCliente.Contacto);
            dbCommandWrapper.AddInParameter("@CH_ESTADO_CLIENTE", DbType.String, oCliente.Estado);
            dbCommandWrapper.AddInParameter("@CH_TIPO_CLIENTE", DbType.String, oCliente.TipoCliente);

            db.ExecuteNonQuery(dbCommandWrapper);

            intCodigoError = Convert.ToInt32(myParam.Value);

            return intCodigoError;
        }

        public int grabarDireccionCliente(int codigoCliente, BEDireccionCliente oDireccion, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_GRABAR_DIRECCION_CLIENTE");

            IDbDataParameter myParam = dbCommandWrapper.Command.CreateParameter(); 
            myParam.DbType = DbType.Int32; 
            myParam.ParameterName = "@IN_CODIGO_DIRECCION"; 
            myParam.Direction = ParameterDirection.InputOutput; 
            myParam.Value = oDireccion.CodigoDireccion;
            dbCommandWrapper.Command.Parameters.Add(myParam);
            
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, codigoCliente);
            dbCommandWrapper.AddInParameter("@VC_DIRECCION", DbType.String, oDireccion.Direccion);
            dbCommandWrapper.AddInParameter("@VC_REFERENCIA", DbType.String, oDireccion.Referencia);
            dbCommandWrapper.AddInParameter("@VC_TELEFONO", DbType.String, oDireccion.Telefono);
            dbCommandWrapper.AddInParameter("@CH_TIPO_DIRECCION", DbType.String, oDireccion.TipoDireccion);

            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);

            int codigoDireccion = Convert.ToInt32(myParam.Value);

            return codigoDireccion;
        }

        public void eliminarDireccionCliente(BECliente oCliente, IDbTransaction mTransaction)
        {
            Database db = DatabaseFactory.CreateDatabase();
            DBCommandWrapper dbCommandWrapper = db.GetStoredProcCommandWrapper("SP_ELIMINAR_DIRECCIONES_CLIENTE");
            dbCommandWrapper.AddInParameter("@IN_CODIGO_CLIENTE", DbType.Int32, oCliente.CodigoCliente);
            db.ExecuteNonQuery(dbCommandWrapper, mTransaction);
        }
    }
}
