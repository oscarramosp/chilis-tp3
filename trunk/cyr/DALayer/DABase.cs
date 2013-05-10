using System.Collections.Generic;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Configuration;
using System.Data;
using System.Text;

namespace DALayer
{
    public class DABase
    {
        #region Propiedades
        private IDbConnection _mconnection;
        private IDbTransaction _mtransaction;
        private Database _mdb;

        protected IDbConnection mconnection
        {
            get
            {
                return _mconnection;
            }
            set
            {
                _mconnection = value;
            }
        }
        public IDbTransaction mtransaction 
        { 
            get 
            {
                return _mtransaction;
            } 
            set 
            {
                _mtransaction = value;
            } 
        }
        protected Database mdb 
        { 
            get 
            {
                return _mdb;
            } 
            set 
            {
                _mdb = value;
            } 
        }
        #endregion

        #region Metodos
        public void mIniciarTransaccion()
        {
            mdb = DatabaseFactory.CreateDatabase();
            mconnection = mdb.GetConnection();
            mconnection.Open();
            mtransaction = mconnection.BeginTransaction();
        }
        public void mCommitTransaccion()
        {
            mtransaction.Commit();
            mtransaction.Dispose();
            mtransaction = null;
            mconnection.Close();
            mconnection.Dispose();
            mconnection = null;
            mdb = null;
        }
        public void mRollbackTransaccion()
        {
            mtransaction.Rollback();
            mtransaction.Dispose();
            mtransaction = null;
            mconnection.Close();
            mconnection.Dispose();
            mconnection = null;
            mdb = null;
        }
        #endregion
    }
}
